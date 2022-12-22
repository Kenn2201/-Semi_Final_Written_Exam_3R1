import 'package:flutter/material.dart';

import 'todo_model.dart';

const List<String> items1 = <String>[
  ' ',
  'true',
  'false',
];
class UpdateTodo extends StatefulWidget {
  final TodoItem updatedTodo;
  const UpdateTodo({Key? key,required this.updatedTodo}) : super(key: key);

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  var formKey = GlobalKey<FormState>();

  late final userIdText =  TextEditingController(text: widget.updatedTodo.userId.toString() ,);
  late final idText =  TextEditingController(text: widget.updatedTodo.id.toString());
  late final titleText =  TextEditingController(text: widget.updatedTodo.title);
  String completedtext = items1.first;


  @override
  void dispose(){
    userIdText.dispose();
    idText.dispose();
    titleText.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add ToDo'),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: userIdText,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'User ID',
                labelText: 'Ex: 1',
              ),
              validator: (idnum){
                return (idnum == '') ? 'Please enter User ID' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: idText,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'ID number',
                labelText: 'Ex: 1',
              ),
              validator: (idnum){
                return (idnum == '') ? 'Please enter ID number' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: titleText,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Title',
                labelText: 'Ex: Harry Potter',
              ),
              validator: (idnum){
                return (idnum == '') ? 'Please enter Title' : null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
                hint: const Text(' '),
                icon: const Icon(Icons.arrow_drop_down),
                value: completedtext,
                onChanged: (String? value){
                  setState(() {
                    completedtext = value!;
                  });
                },
                items: items1.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 20,
              child: ElevatedButton(
                onPressed: () async{
                  var validform = formKey.currentState!.validate();
                  if (validform) {
                    print('The Text Inputted are valid!');
                    TodoItem newTodoitem = TodoItem(
                      userId: int.parse(userIdText.text),
                      id: int.parse(idText.text),
                      title: titleText.text,
                      completed: completedtext,
                    );

                    print(newTodoitem);
                    Navigator.pop(context,newTodoitem);
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

