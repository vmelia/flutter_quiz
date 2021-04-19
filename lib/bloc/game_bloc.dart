import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../colours.dart';
import '../model/quiz_data.dart';
import '../model/quiz_item.dart';

// Events.
@immutable
abstract class GameEvent {}

class AttemptAnswerEvent extends GameEvent {
  final QuizItem left;
  final QuizItem right;
  AttemptAnswerEvent(this.left, this.right);
}

// States.
@immutable
abstract class GameState {}

class GameInitial extends GameState {}

abstract class AnswerState extends GameState {
  final String text;
  final Color colour;
  AnswerState(this.text, this.colour);
}

class AnswerCorrectState extends AnswerState {
  final int value;
  AnswerCorrectState(this.value) : super('Correct', Colours.answerCorrect);
}

class AnswerIncorrectState extends AnswerState {
  AnswerIncorrectState() : super('Incorrect', Colours.answerIncorrect);
}

// Bloc.
class GameBloc extends Bloc<GameEvent, GameState> {
  QuizData quizData;

  GameBloc() : super(GameInitial());

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is AttemptAnswerEvent) {
      log('AttemptAnswerEvent(${event.left.name} (${event.left.value}), ${event.right.name}: (${event.right.value}))');
      if (event.left.value == event.right.value) {
        yield AnswerCorrectState(event.left.value);
      } else {
        yield AnswerIncorrectState();
      }
    }
  }
}
