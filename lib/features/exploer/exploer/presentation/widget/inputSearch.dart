import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_cubit.dart';

class InputWidget extends StatelessWidget {

  const InputWidget({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
