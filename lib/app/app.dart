import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/game_bloc.dart';
import '../bloc/grid_bloc.dart';
import '../colours.dart';
import '../pages/quiz_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GridBloc>(
          create: (_) => GridBloc()..add(LoadDataEvent('assets/data/states.json')),
        ),
        BlocProvider<GameBloc>(create: (context) => GameBloc()),
      ],
      child: _buildApp(context),
    );
  }
}

Widget _buildApp(BuildContext context) {
  return MaterialApp(
    theme: ThemeData(
      //scaffoldBackgroundColor: Colours.appBackground,
      accentColor: Colours.appAccent,
      appBarTheme: AppBarTheme(color: Colours.appBar),
    ),
    home: const QuizPage(),
  );
}
