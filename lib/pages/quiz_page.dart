import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/answer_bloc.dart';
import '../bloc/data_bloc.dart';
import '../widgets/quiz_view.dart';

class QuizPage extends StatelessWidget {
  const QuizPage();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DataBloc>(
          create: (_) => DataBloc()..add(LoadDataEvent('assets/data/states.json')),
        ),
        BlocProvider<AnswerBloc>(
          create: (_) => AnswerBloc(),
        ),
      ],
      child: QuizView(),
    );
  }
}
