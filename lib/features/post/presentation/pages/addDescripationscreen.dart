import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/constants_routes.dart';
import '../../../profileUser/presentation/manager/profile_cubit.dart';
import '../manager/post_cubit.dart';

class AddDescriptionScreen extends StatelessWidget {
  AddDescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postCubit = context.read<PostCubit>();

    return Scaffold(
      appBar: AppBar(title: Text("Add Description")),
      body: BlocConsumer<PostCubit, PostState>(
        listener: (context, state) {
          if (state is CreatePostSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Post Created Successfully!"),
                backgroundColor: Colors.green,
              ),
            );
            BlocProvider.of<ProfileCubit>(context).fetchUserProfile();

          } else if (state is CreatePostFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: ${state.errorMessage}"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if(state is CreatePostLoading){
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: postCubit.formKey,
              child: Column(
                children: [
                  // Display the image
                  if (postCubit.postImage != null)
                    Image.file(postCubit.postImage!,
                        height: 200, width: 200, fit: BoxFit.cover),
                  SizedBox(height: 20),
                  //  add description
                  TextFormField(
                    controller: postCubit.descriptionController,
                    decoration: InputDecoration(
                      labelText: "Add a description",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final currentUser =
                          context.read<ProfileCubit>().currentUser;
                      if (currentUser != null) {
                        postCubit.createPost(currentUser);
                        context.go(ConstantsRoutes.homeScreen);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("User data is not loaded. Please try again."),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Text("Share"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}