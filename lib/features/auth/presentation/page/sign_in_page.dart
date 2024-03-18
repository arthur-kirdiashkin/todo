import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import 'package:text_editor_test/features/auth/biometric/bloc/biometric_bloc.dart';
import 'package:text_editor_test/features/auth/form-validation/bloc/form_bloc.dart';
import 'package:text_editor_test/features/auth/form-validation/sign_up_page.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_event.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_state.dart';
import 'package:text_editor_test/features/todo/presentation/page/todo_page.dart';
import 'package:text_editor_test/utils/constants.dart';

OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final LocalAuthentication auth = LocalAuthentication();
  String? email;

  String? password;

  int tries = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocListener(
      listeners: [
        BlocListener<FormBloc, FormsValidate>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      ErrorDialog(errorMessage: state.errorMessage));
            } else if (state.isFormValid && !state.isLoading) {
              context.read<AuthenticationBloc>().add(AuthenticationStarted());
            } else if (state.isFormValidateFailed) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please fill the data correctly!")));
            }
          },
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const TodoPage()),
                  (Route<dynamic> route) => false);
            }
          },
        ),
        // BlocListener<BiometricBloc, BiometricState>(
        //   listener: (context, state) {
        //     if (state is BiometricTriesExceededState) {
        //       biometric = false;
        //     }
        //   },
        // ),
      ],
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.white),
          ),
          backgroundColor: Colors.white,
          body: Center(
              child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Welcome back!",
                        style: TextStyle(
                          color: Constants.kBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        )),
                  ])),
              SizedBox(height: size.height * 0.01),
              const Text(
                Constants.textSmallSignIn,
                style: TextStyle(color: Constants.kDarkGreyColor),
              ),
              Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
              const _EmailField(),
              SizedBox(height: size.height * 0.01),
              const _PasswordField(),
              SizedBox(height: size.height * 0.01),
              const _SubmitButton(),
              const _SignInNavigate(),
            ]),
          ))),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
              onChanged: (value) {
                context.read<FormBloc>().add(EmailChanged(value));
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                helperText: 'A complete, valid email e.g. joe@gmail.com',
                errorText: !state.isEmailValid
                    ? 'Please ensure the email entered is valid'
                    : null,
                hintText: 'Email',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                border: border,
              )),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
              helperText:
                  '''Password should be at least 8 characters with at least one letter and number''',
              helperMaxLines: 2,
              labelText: 'Password',
              errorMaxLines: 2,
              errorText: !state.isPasswordValid
                  ? '''Password must be at least 8 characters and contain at least one letter and number'''
                  : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(PasswordChanged(value));
            },
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: size.width * 0.8,
                child: OutlinedButton(
                  onPressed: !state.isFormValid
                      ? () => context
                          .read<FormBloc>()
                          .add(const FormSubmitted(value: Status.signIn))
                      : null,
                  child: const Text("Sign In"),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide.none)),
                ),
              );
      },
    );
  }
}

class _SignInNavigate extends StatelessWidget {
  const _SignInNavigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: <TextSpan>[
          const TextSpan(
              text: Constants.textAcc,
              style: TextStyle(
                color: Color(0xFF9E9E9E),
              )),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () => {
                      Navigator.of(context).pop(),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      )
                    },
              text: Constants.textSignUp,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF6057FF),
              )),
        ]));
  }
}

class ErrorDialog extends StatelessWidget {
  final String? errorMessage;
  const ErrorDialog({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(errorMessage!),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
