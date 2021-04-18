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

// States.
@immutable
abstract class GridState {}

class GridInitial extends GridState {}

class DataLoadingState extends GridState {}

class DataLoadedState extends GridState {
  final QuizData quizData;

  DataLoadedState(this.quizData);
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
      yield DataLoadedState(quizData);
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
