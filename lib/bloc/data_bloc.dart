import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../entities/question_pair.dart';
import '../model/quiz_item.dart';
import '../model/quiz_repository.dart';

// Events.
@immutable
abstract class DataEvent {}

class LoadDataEvent extends DataEvent {
  final String assetPath;

  LoadDataEvent(this.assetPath);
}

// States.
@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class DataLoadingState extends DataState {}

class DataLoadedState extends DataState {
  final List<QuizItem> leftList;
  final List<QuizItem> rightList;

  DataLoadedState(this.leftList, this.rightList);
}

// Bloc.
class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is LoadDataEvent) {
      yield DataLoadingState();
      final data = await load(event.assetPath);
      yield createLoadDataState(data);
    }
  }
}

Future<List<QuestionPair>> load(String assetPath) async {
  final quizRepository = QuizRepositoryImpl(); //ToDo: Inject.
  return await quizRepository.load(assetPath);
}

DataLoadedState createLoadDataState(List<QuestionPair> data) {
  var leftList = <QuizItem>[];
  var rightList = <QuizItem>[];

  for (var i = 0; i < data.length; i++) {
    leftList.add(QuizItem(data[i].left, i));
    rightList.add(QuizItem(data[i].right, i));
  }

  rightList.sort((a, b) => a.name.compareTo(b.name));
  return DataLoadedState(leftList, rightList);
}
