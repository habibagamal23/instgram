import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../bloc/exploers_cubit.dart';
import 'inputSearch.dart';


class SearchMainWidget extends StatefulWidget {
  const SearchMainWidget({Key? key}) : super(key: key);

  @override
  _SearchMainWidgetState createState() => _SearchMainWidgetState();
}

class _SearchMainWidgetState extends State<SearchMainWidget> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ExploersCubit>(context).fetchExploersPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
      ),
      body: Column(
        children: [
          // Search box at the top
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputWidget(),
          ),
          // Expanded area for the grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<ExploersCubit, ExploersState>(
                  builder: (context, state) {
                    if(state is ExploersLoading){
                      return Center(child: CircularProgressIndicator());
                    }
                    if(state is ExploersError){
                      return Center(child: Text(state.error));
                    }

                    if(state is ExploersLoaded){

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
                              height: (index % 5 + 1) * 100,
                              post.imageURL!,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }

               return  Center(child: Text("No posts found"));
              })
            ),
          ),
        ],
      ),
    );
  }
}
