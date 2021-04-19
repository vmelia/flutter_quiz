import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game_bloc.dart';
import '../bloc/grid_bloc.dart';
import '../colours.dart';
import '../widgets/info_bar.dart';
import '../widgets/quiz_view.dart';

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }
}

Widget _buildPage(BuildContext context) {
  return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: QuizView()),
        BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state is AnswerCorrectState) {
              context.read<GridBloc>().add(RemoveCorrectAnswerEvent(state.value));
              return InfoBar(state.text, state.colour);
            } else if (state is AnswerIncorrectState) {
              return InfoBar(state.text, state.colour);
            } else {
              return InfoBar('', Colours.answerNeutral);
            }
          },
        ),
      ],
    ),
  );
}
