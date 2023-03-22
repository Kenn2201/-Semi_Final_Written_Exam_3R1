

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'todo_model.dart';

class AddProfile extends StatefulWidget {
  const AddProfile({Key? key}) : super(key: key);

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _addressController = TextEditingController();
  final _hobbiesController = TextEditingController();

  File? _image;
  String _imageUrl = "";
  @override
  void dispose(){
    _nameController.dispose();
    _ageController.dispose();
    _birthdateController.dispose();
    _addressController.dispose();
    _hobbiesController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('Add Profile Info'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  Center(

                    child: GestureDetector(
                      onTap: (){},
                      child: _image == null
                          ? const CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('assets/profile.png'),
                      )
                          : CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(_image!),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Age';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Birthdate',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Birthdate';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Address';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Hobbies',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Hobbies';
                      }
                      return null;
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
