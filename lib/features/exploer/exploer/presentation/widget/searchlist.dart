import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../bloc/exploers_cubit.dart';
import '../bloc/ontherprofile_cubit.dart';
import '../bloc/search_cubit.dart';
import '../pages/ontherProfilescreen.dart';

class Searchlist extends StatelessWidget {
  const Searchlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, searchState) {
        if (searchState is SearchLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (searchState is SearchSuccess) {
          return ListView.builder(
            itemCount: searchState.users.length,
            itemBuilder: (context, index) {
              final user = searchState.users[index];
              return InkWell(
                onTap: () {
                  BlocProvider.of<OntherprofileCubit>(context)
                      .fetchUserProfile(user.uid!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Ontherprofilescreen()));
                },
                child: Card(
                  elevation: 1,
                  color: Colors.grey.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(user.username!),
                    subtitle: Text(user.email!),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.profileUrl!),
                    ),
                  ),
                ),

              );
            },
          );
        }
        if (searchState is SearchError) {
          return Center(child: Text(searchState.message));
        }
        return Center(child: Text("No results"));
      },
    );
  }
}
