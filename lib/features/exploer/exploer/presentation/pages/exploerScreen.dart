import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaflutter/features/exploer/exploer/presentation/bloc/explorescubit/exploers_cubit.dart';

import '../../../../../core/di/di.dart';
import '../../data/repository/searchrepo.dart';
import '../bloc/explorescubit/search_cubit.dart';
import '../widget/SearchMainWidget.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ExploersCubit>()),
        BlocProvider(create: (context) => getIt<SearchCubit>())
      ],
      child: SearchMainWidget(),
    );
  }
}
