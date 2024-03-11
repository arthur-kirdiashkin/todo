import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    final wordsController = TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 156, 189),
      appBar: AppBar(
        title: Center(child: Text('TO DO App')),
      ),
      body: Center(child: Container(child: Text('Типо страница с ТОДО'),)),
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
