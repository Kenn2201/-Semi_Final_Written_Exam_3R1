import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'todo_model.dart';

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

  Widget _buildProfileImage(dynamic image) {
    if (_imageFile != null) {
      return CircleAvatar(
        backgroundImage: FileImage(_imageFile!),
        radius: 150,
      );
    } else if (image != null) {
      if (image is String) {
        File file = File(image);
        if (file.existsSync()) {
          return CircleAvatar(
            backgroundImage: FileImage(file),
            radius: 150,
          );
        } else {
          return const SizedBox();
        }
      } else if (image is Uint8List) {
        return CircleAvatar(
          backgroundImage: MemoryImage(image),
          radius: 100,
        );
      }
    }
    return CircleAvatar(
      radius: 100,
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
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('About Me Info'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Center(child: _buildProfileImage(widget.todo.imagePath)),
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
