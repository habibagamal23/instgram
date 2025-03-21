import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaflutter/features/exploer/exploer/presentation/bloc/exploers_cubit.dart';

import '../../../../../core/di/di.dart';
import '../widget/SearchMainWidget.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => getIt<ExploersCubit>(),
      child: SearchMainWidget(),
    );
  }
}