import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/post_cubit.dart';
import 'addDescripationscreen.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);

  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Post")),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      // Pass the image to the PostCubit
                      context.read<PostCubit>().setImage(File(pickedFile.path));
                     //next button
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDescriptionScreen(),
                        ),
                      );
                    }
                  },
                  child: Text("Choose Image"),
                ),
                if (state is UploadImageforPost)
                  Image.file(state.imageFile, height: 200, width: 200, fit: BoxFit.cover),
              ],
            ),
          );
        },
      ),
    );
  }
}
