part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class DataLoadingState extends DataState {}

class DataLoadedState extends DataState {
  final List<QuizItem> leftList;
  final List<QuizItem> rightList;

  DataLoadedState(this.leftList, this.rightList);
}
