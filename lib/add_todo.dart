import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'todo_model.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  var formKey = GlobalKey<FormState>();

  final idText =  TextEditingController();

  final nametext = TextEditingController();
  final agetext= TextEditingController();
  final birthdatetext = TextEditingController();
  final addresstext = TextEditingController();
  final hobbiestext = TextEditingController();



  @override
  void dispose(){
    idText.dispose();

    nametext.dispose();
    agetext.dispose();
    birthdatetext.dispose();
    addresstext.dispose();
    hobbiestext.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Info'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [


            TextFormField(
              controller: idText,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Ex. 1',
                labelText: 'ID number',
              ),
              validator: (idnum){
                return (idnum == '') ? 'Please enter ID number' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nametext,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Ex: Kenn Vincent A. Nacario',
                labelText: 'Input Name',
              ),
              validator: (idnum){
                return (idnum == '') ? 'Please enter name' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: agetext,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Ex: 22',
                labelText: 'Input age',
              ),
              validator: (idnum){
                return (idnum == '') ? 'Please enter age' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: birthdatetext,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Ex: 02/02/2001',
                labelText: 'Input birthdate',
              ),
              validator: (idnum){
                return (idnum == '') ? 'Please enter birthdate' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: addresstext,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Ex: Barra Opol, Misamis Oriental',
                labelText: 'Input address',
              ),
              validator: (idnum){
                return (idnum == '') ? 'Please enter address' : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: hobbiestext,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Ex: ''[biking,fishing,cooking]''',
                labelText: 'Input hobbies',
              ),
              validator: (idnum){
                return (idnum == '') ? 'Please enter hobbies' : null;
              },
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
                          id: int.parse(idText.text),
                          name: nametext.text,
                          age: int.parse(agetext.text),
                          birthdate: birthdatetext.text,
                          address: addresstext.text,
                          hobbies: hobbiestext.text,

                        );
                    await DatabaseHelper.instance.add(newTodoitem);
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

