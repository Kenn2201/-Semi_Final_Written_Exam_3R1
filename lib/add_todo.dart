import 'package:flutter/material.dart';
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
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Widget _buildProfileImage() {

    if (_imageFile != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CircleAvatar(
            backgroundImage: FileImage(_imageFile!),
            radius: 70,
          ),

        ],
      );
    } else {
      return CircleAvatar(
        radius: 70,
        child: IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.photo_camera),
                        title: const Text('Take a picture'),
                        onTap: () {
                          _pickImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text('Choose from gallery'),
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      );
    }
  }



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
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('Add Info'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(child: _buildProfileImage()),
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

                    if (_imageFile == null) {
                      return;
                    }
                    List<int> imageBytes = await _imageFile!.readAsBytes();
                    TodoItem newTodoitem = TodoItem(
                          id: int.parse(idText.text),
                          name: nametext.text,
                          age: int.parse(agetext.text),
                          birthdate: birthdatetext.text,
                          address: addresstext.text,
                          hobbies: hobbiestext.text,
                          imagePath: imageBytes as dynamic,
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

