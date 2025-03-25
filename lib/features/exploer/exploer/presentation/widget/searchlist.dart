import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instaflutter/features/exploer/exploer/presentation/pages/anotherProfilescreen.dart';
import '../bloc/explorescubit/exploers_cubit.dart';
import '../bloc/anothercubit/ontherprofile_cubit.dart';
import '../bloc/explorescubit/search_cubit.dart';

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
                      .listenToUserProfile(user.uid!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => anotherprofilescreen()));
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
