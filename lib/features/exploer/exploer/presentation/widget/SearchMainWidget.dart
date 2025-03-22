import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instaflutter/features/exploer/exploer/presentation/widget/searchlist.dart';
import '../bloc/exploers_cubit.dart';
import '../bloc/search_cubit.dart';
import 'ExplorList.dart';

class SearchMainWidget extends StatefulWidget {
  const SearchMainWidget({Key? key}) : super(key: key);

  @override
  _SearchMainWidgetState createState() => _SearchMainWidgetState();
}

class _SearchMainWidgetState extends State<SearchMainWidget> {
  String query = "";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExploersCubit>(context).fetchExploersPosts();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
           child:  Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.3),
                borderRadius: BorderRadius.circular(15),
              ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (newQuery) {
                setState(() {
                  query = newQuery;
                });
                BlocProvider.of<SearchCubit>(context).search(newQuery);
              },
            ),
          ),),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: query.isEmpty
                  ? Explorlist()
                  : Searchlist()
            ),
          ),
        ],
      ),
    );
  }
}
