import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_event.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:text_editor_test/features/todo/presentation/blocs/todo_bloc/todo_event.dart';
import 'package:text_editor_test/features/todo/presentation/page/todo_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Settings Page'),
        ),
        body: ListView(
          children: [
            LogOutButton(),
            DeleteAllFilesButton(),
          ],
        ));
  }
}

class LogOutButton extends StatefulWidget {
  const LogOutButton({super.key});

  @override
  State<LogOutButton> createState() => _LogOutButtonState();
}

class _LogOutButtonState extends State<LogOutButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AuthenticationBloc>().add(AuthenticationSignedOut());
      },
      child: Card(
          child: ListTile(
        trailing: Icon(Icons.logout),
        title: Text('Log out of your account'),
      )),
    );
  }
}

class DeleteAllFilesButton extends StatefulWidget {
  const DeleteAllFilesButton({super.key});

  @override
  State<DeleteAllFilesButton> createState() => _DeleteAllFilesButtonState();
}

class _DeleteAllFilesButtonState extends State<DeleteAllFilesButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<TodoBloc>().add(DeleteAllDocumentsEvent());
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => TodoPage()),
        //     (Route<dynamic> route) => false);
        Navigator.of(context).pop();
      },
      child: Card(
          child: ListTile(
        trailing: Icon(Icons.delete_forever),
        title: Text('Delete All Files'),
      )),
    );
  }
}
