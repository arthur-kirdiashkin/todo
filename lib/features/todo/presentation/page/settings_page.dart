
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/encrypt_bloc/encrypt_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/encrypt_bloc/encrypt_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/encrypt_bloc/encrypt_state.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_event.dart';


final passwordKey = GlobalKey<FormState>();

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var hidePassword;
  final passwordController = TextEditingController();

  @override
  void initState() {
    hidePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EncryptBloc, EncryptState>(
      listener: (context, state) {
        if (state is AddEncryptStateLoaded) {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          key: passwordKey,
                          child: TextFormField(
                            // validator: validPassword,
                            obscureText: hidePassword,
                            controller: passwordController,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: hidePassword
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                              fillColor: const Color.fromARGB(255, 255, 232, 240),
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 10,
                                  color: Color.fromARGB(255, 108, 189, 255),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (passwordKey.currentState!.validate()) {
                              context.read<EncryptBloc>().add(EncryptDataEvent(
                                    password: passwordController.text,
                                  ));
                            }
                          },
                          child: const Text('Encrypt'),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text('Settings Page'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _LogOutButton(),
              const _DeleteAllFilesButton(),
              _FirebaseOptionalButton(),
            ],
          )),
    );
  }

  String? validPassword(String? value) {
    if (value!.length != 4) {
      return 'Password must be 4 symbols';
    } else {
      return null;
    }
  }
}

class _LogOutButton extends StatefulWidget {
  const _LogOutButton({super.key});

  @override
  State<_LogOutButton> createState() => _LogOutButtonState();
}

class _LogOutButtonState extends State<_LogOutButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AuthenticationBloc>().add(AuthenticationSignedOut());
      },
      child: const Card(
          child: ListTile(
        trailing: Icon(Icons.logout),
        title: Text('Log out of your account'),
      )),
    );
  }
}

class _DeleteAllFilesButton extends StatefulWidget {
  const _DeleteAllFilesButton({super.key});

  @override
  State<_DeleteAllFilesButton> createState() => _DeleteAllFilesButtonState();
}

class _DeleteAllFilesButtonState extends State<_DeleteAllFilesButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<TodoBloc>().add(DeleteAllDocumentsEvent());
        Navigator.of(context).pop();
      },
      child: const Card(
          child: ListTile(
        trailing: Icon(Icons.delete_forever),
        title: Text('Delete All Data'),
      )),
    );
  }
}

class _FirebaseOptionalButton extends StatefulWidget {
  _FirebaseOptionalButton({super.key});

  @override
  State<_FirebaseOptionalButton> createState() =>
      _FirebaseOptionalButtonState();
}

class _FirebaseOptionalButtonState extends State<_FirebaseOptionalButton> {
  var isSaveInFirebase;
  @override
  void initState() {
    getIsSelected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSaveInFirebase = !isSaveInFirebase;
          context
              .read<TodoBloc>()
              .add(IsSaveInFirebaseEvent(isSaveInFirebase: isSaveInFirebase));
        });
      },
      child: Card(
        color: isSaveInFirebase == true
            ? Colors.white
            : const Color.fromARGB(255, 253, 142, 134),
        child: ListTile(
          title: isSaveInFirebase == true
              ? const Text('Save in Firebase : true')
              : const Text('Save in Firebase : false'),
          trailing: const Icon(Icons.save),
        ),
      ),
    );
  }

  Future<void> getIsSelected() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool _isSaveInFirebase = ((prefs.getBool('isSelected')) ?? true);
      isSaveInFirebase = _isSaveInFirebase;
    });
  }
}

class _EncryptedButton extends StatefulWidget {
  const _EncryptedButton({super.key});

  @override
  State<_EncryptedButton> createState() => _EncryptedButtonState();
}

class _EncryptedButtonState extends State<_EncryptedButton> {
  var myPassword;

  @override
  void setState(VoidCallback fn) {
    getString();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<EncryptBloc>().add(AddEncryptDataEvent());
      },
      child: Card(
          color: myPassword == null
              ? const Color.fromARGB(255, 253, 142, 134)
              : Colors.white,
          child: ListTile(
            trailing: const Icon(Icons.no_encryption),
            title: myPassword == null
                ? const Text('Encrypt: false')
                : const Text('Encrypt: true'),
          )),
    );
  }

  Future<void> getString() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final password = prefs.getString('key');
    myPassword = password;
  }
}
