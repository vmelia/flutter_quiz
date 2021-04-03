part of 'selection_bloc.dart';

@immutable
abstract class SelectionState {
  final int index;

  SelectionState(this.index);
}

class SelectionInitial extends SelectionState {
  SelectionInitial() : super(0);
}

class PageChangedState extends SelectionState {
  PageChangedState(int selected) : super(selected);
}

class SelectionChangedState extends SelectionState {
  SelectionChangedState(int selected) : super(selected);
}