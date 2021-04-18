import 'dart:async';

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

class RemoveCorrectAnswerEvent extends GameEvent {
  final int value;

  RemoveCorrectAnswerEvent(this.value);
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
  AnswerCorrectState() : super('Correct', Colours.answerCorrect);
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
      if (event.left.value == event.right.value) {
        yield AnswerCorrectState();
      } else {
        yield AnswerIncorrectState();
      }
    }
  }
}