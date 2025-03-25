
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../bloc/explorescubit/exploers_cubit.dart';
import '../bloc/explorescubit/search_cubit.dart';
class  Explorlist extends StatelessWidget {
  const Explorlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploersCubit, ExploersState>(
        builder: (context, state) {
          if (state is ExploersLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ExploersError) {
            return Center(child: Text(state.error));
          }

          if (state is ExploersLoaded) {
            return MasonryGridView.builder(
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    post.imageURL!,
                    height: (index % 5 + 1) * 100,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }

          return Center(child: Text("No posts found"));
        });
  }
}

