import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../model/quiz_item.dart';

// Events.
@immutable
abstract class AnswerEvent {}

class AttemptAnswerEvent extends AnswerEvent {
  final QuizItem left;
  final QuizItem right;
  AttemptAnswerEvent(this.left, this.right);
}

// States.
@immutable
abstract class AnswerState {}

class AnswerInitial extends AnswerState {}

class AnswerCorrectState extends AnswerState {}

class AnswerIncorrectState extends AnswerState {}

// Bloc.
class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  AnswerBloc() : super(AnswerInitial());

  @override
  Stream<AnswerState> mapEventToState(AnswerEvent event) async* {
    if (event is AttemptAnswerEvent) {
      if (event.left.value == event.right.value){
        // Correct.
          yield AnswerCorrectState(); //ToDo: +
      } else{
          yield AnswerIncorrectState(); //ToDo: +
      }
    }
  }
}
