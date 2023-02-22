import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ToDoInfo extends StatefulWidget {
  final dynamic todo;

  const ToDoInfo({required this.todo, Key? key}) : super(key: key);

  @override
  State<ToDoInfo> createState() => _ToDoInfoState();
}

class _ToDoInfoState extends State<ToDoInfo> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveImage() async {
    // Here, you would typically save the image file to your database or storage service
    // For this example, we'll just print a message to the console
    print('Image saved!');
  }


  Widget _buildProfileImage() {
    if (_imageFile != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CircleAvatar(
            backgroundImage: FileImage(_imageFile!),
            radius: 50,
          ),
          Container(
            width: 100,
            height: 32,
            color: Colors.black54,
            child: TextButton(
              onPressed: _saveImage,
              child: const Text(
                'Save Image',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      );
    } else {
      return CircleAvatar(
        child: IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.photo_camera),
                        title: Text('Take a picture'),
                        onTap: () {
                          _pickImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text('Choose from gallery'),
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
        radius: 50,
      );
    }
  }

  Widget rowItem(String title, dynamic value) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(title),
        ),
        const SizedBox(width: 5),
        Text(value.toString())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me Info'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Center(child: _buildProfileImage()),
          const SizedBox(height: 10),
          rowItem("ID", widget.todo.id),
          rowItem("Name", widget.todo.name),
          rowItem("Age", widget.todo.age),
          rowItem("Birthdate", widget.todo.birthdate),
          rowItem("Address", widget.todo.address),
          rowItem("Hobbies", widget.todo.hobbies),
        ],
      ),
    );
  }
}
