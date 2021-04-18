import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/game_bloc.dart';

class InfoBar extends StatelessWidget {
  final String text;
  final Color colour;
  InfoBar(this.text, this.colour);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 30.0),
          child: Text(
            text,
            style: TextStyle(
              color: colour,
              fontSize: 24,
            ),
          ),
        );
      },
    );
  }
}
