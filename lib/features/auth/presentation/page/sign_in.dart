import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_event.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_state.dart';
import 'package:text_editor_test/features/auth/presentation/page/sign_up.dart';
import 'package:text_editor_test/features/todo/presentation/page/todo_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignIn"),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const TodoPage()));
          }
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticatedState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Center(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    hintText: "Email",
                                    border: OutlineInputBorder(),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return value != null &&
                                            !EmailValidator.validate(value)
                                        ? 'Enter a valid email'
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                    border: OutlineInputBorder(),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return value != null && value.length < 6
                                        ? "Enter min. 6 characters"
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _authenticateWithEmailAndPassword(
                                          context);
                                    },
                                    child: const Text('Sign In'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Text("Don't have an account?"),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: const Text("Sign Up"),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(SignInRequested(
          email: _emailController.text, password: _passwordController.text));
    }
  }
}
