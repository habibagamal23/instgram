import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/inputSearch.dart';
import '../bloc/search_cubit.dart';
class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    // This makes the field read-only if isReadOnly is true
                    onChanged: (query) {

                      context.read<SearchCubit>().search(query); // Trigger search only if not read-only

                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
            ),
            SizedBox(height: 10),
            // Display search results
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is SearchSuccess) {
                    return ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return ListTile(
                          title: Text(user.username!),
                          subtitle: Text(user.email!), // Adjust as needed
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.profileUrl!),
                          ),
                        );
                      },
                    );
                  }
                  if (state is SearchError) {
                    return Center(child: Text(state.message));
                  }
                  return Center(child: Text("No results"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
