import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../entities/question_pair.dart';
import '../model/quiz_item.dart';
import '../model/quiz_repository.dart';

part 'data_event.dart';
part 'data_state.dart';

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

  return DataLoadedState(leftList, rightList);
}
