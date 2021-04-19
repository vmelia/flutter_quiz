import 'package:flutter/material.dart';

import '../colours.dart';

class ChooseGamePage extends StatelessWidget {
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
        Text('Choose a game'),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colours.buttonDeselected,
            side: BorderSide(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            //
          },
          child: Text(
            'US State Capitols',
            style: TextStyle(color: Colours.buttonDeselectedText, fontSize: 17),
          ),
        ),
      ],
    ),
  );
}
