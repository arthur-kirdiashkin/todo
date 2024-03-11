import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_bloc.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_event.dart';
import 'package:text_editor_test/features/auth/presentation/authBloc/authentication_state.dart';
import 'package:text_editor_test/features/auth/presentation/page/sign_in.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final wordsController = TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 156, 189),
      appBar: AppBar(
        title: Center(child: Text('TO DO App')),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticatedState) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignIn()),
              (route) => false,
            );
          }
          if(state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Column(
          children: [
            Center(
                child: Container(
              child: Text(' ТОДО Лист'),
            )),
            SizedBox(
              height: 16,
            ),
            Text('Email: ${user.email}'),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              child: const Text('Sign Out'),
              onPressed: () {
                // Signing out the user
                context.read<AuthBloc>().add(SignOutRequested());
              },
            ),
          ],
        ),
      ),
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(18.0),
      //       child: Row(
      //         children: [
      //           Expanded(
      //             child: TextField(
      //               controller: wordsController,
      //               style: TextStyle(
      //                 color: Colors.black,
      //               ),
      //               decoration: InputDecoration(
      //                 fillColor: Color.fromARGB(255, 255, 178, 204),
      //                 filled: true,
      //                 border: OutlineInputBorder(
      //                   borderSide: BorderSide(
      //                     width: 10,
      //                     color: Color.fromARGB(255, 108, 189, 255),
      //                   ),
      //                   borderRadius: BorderRadius.circular(15),
      //                 ),
      //                 enabledBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(
      //                     color: Colors.black,
      //                   ),
      //                   borderRadius: BorderRadius.circular(15),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           Container(
      //             padding: EdgeInsets.only(left: 10),
      //             height: 60,
      //             child: ElevatedButton(
      //               style: ButtonStyle(
      //                 backgroundColor:
      //                     MaterialStatePropertyAll(Colors.blueAccent),
      //                 shape: MaterialStatePropertyAll(RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(15))),
      //               ),
      //               onPressed: (){

      //               },
      //               child: Text(
      //                 '+',
      //                 style: TextStyle(fontSize: 40),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //           SizedBox(height: 40,),
      //     Expanded(
      //       child: ListView.builder(
      //         padding: EdgeInsets.symmetric(horizontal: 15),
      //         itemCount: addTodoItem.length,
      //         itemExtent: 80,
      //         itemBuilder: (BuildContext context, int index) {
      //           final todoRow = addTodoItem[index];
      //           return Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: ListTile(
      //               tileColor: Colors.white,
      //               title: Text(
      //                 todoRow.text,
      //                 style: TextStyle(
      //                     decoration:
      //                         todoRow.isDone ? TextDecoration.lineThrough : null),
      //               ),
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(15),
      //               ),
      //               leading: Checkbox(
      //                   value: todoRow.isDone,
      //                   activeColor: Colors.green,
      //                   onChanged: (bool? newValue) {
      //                     setState(() {
      //                       todoRow.isDone = newValue!;
      //                     });
      //                   }),
      //               trailing: InkWell(
      //                 child: Icon(Icons.delete, color: Colors.red,),
      //                 onTap: () {
      //                   deleteRow(todoRow.id);
      //                 }
      //               ),
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // );
    );
  }
}
