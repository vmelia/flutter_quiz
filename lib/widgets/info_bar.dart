import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/game_bloc.dart';
import '../colours.dart';

class InfoBar extends StatelessWidget {
  final String text;
  final Color colour;
  InfoBar(this.text, this.colour);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              color: colour,
              border: Border.all(
                  color: Colours.text, // Set border color
                  width: 1.0), // Set border width
              borderRadius: BorderRadius.all(Radius.circular(30.0)), // Set rounded corner radius
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.transparent, offset: Offset(1, 3))]),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 15.0, right: 10.0, bottom: 15.0),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colours.text,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
