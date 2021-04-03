part of 'selection_bloc.dart';

@immutable
abstract class SelectionState {}

class SelectionInitial extends SelectionState {}

class LeftSelectionChangedState extends SelectionState {
  final int selected;
  LeftSelectionChangedState(this.selected);
}

class RightSelectionChangedState extends SelectionState {
  final int selected;
  RightSelectionChangedState(this.selected);
}
