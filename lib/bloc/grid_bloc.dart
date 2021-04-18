import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../entities/question_pair.dart';
import '../model/quiz_data.dart';
import '../model/quiz_item.dart';
import '../model/quiz_repository.dart';

// Events.
@immutable
abstract class GridEvent {}

class LoadDataEvent extends GridEvent {
  final String assetPath;

  LoadDataEvent(this.assetPath);
}

class RemoveCorrectAnswerEvent extends GridEvent {
  final int value;

  RemoveCorrectAnswerEvent(this.value);
}

// States.
@immutable
abstract class GridState {}

class GridInitial extends GridState {}

class DataLoadingState extends GridState {}

class DataChangedState extends GridState {
  final QuizData quizData;
  final bool removedRow;

  DataChangedState(this.quizData, {this.removedRow = false});
}

// Bloc.
class GridBloc extends Bloc<GridEvent, GridState> {
  QuizData quizData;

  GridBloc() : super(GridInitial());

  @override
  Stream<GridState> mapEventToState(GridEvent event) async* {
    if (event is LoadDataEvent) {
      yield DataLoadingState();
      final rawData = await load(event.assetPath);
      quizData = createQuizData(rawData);
      yield DataChangedState(quizData);
    } else if (event is RemoveCorrectAnswerEvent) {
      quizData.left.removeWhere((x) => x.value == event.value);
      quizData.right.removeWhere((x) => x.value == event.value);
      yield DataChangedState(quizData, removedRow: true);
    }
  }
}

Future<List<QuestionPair>> load(String assetPath) async {
  final quizRepository = QuizRepositoryImpl(); //ToDo: Inject.
  return await quizRepository.load(assetPath);
}

QuizData createQuizData(List<QuestionPair> data) {
  var leftList = <QuizItem>[];
  var rightList = <QuizItem>[];

  for (var i = 0; i < data.length; i++) {
    leftList.add(QuizItem(data[i].left, i));
    rightList.add(QuizItem(data[i].right, i));
  }

  leftList.sort((a, b) => a.name.compareTo(b.name));
  rightList.sort((a, b) => a.name.compareTo(b.name));

  return QuizData(leftList, rightList);
}
