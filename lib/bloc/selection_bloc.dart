import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

// Events.
@immutable
abstract class SelectionEvent {}

// User swipes the carousel.
class PageChangedEvent extends SelectionEvent {
  final int index;
  PageChangedEvent(this.index);
}

// User clicks on a button.
class SelectionChangedEvent extends SelectionEvent {
  final int index;
  SelectionChangedEvent(this.index);
}

// States.
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

// Bloc.
class SelectionBloc extends Bloc<SelectionEvent, SelectionState> {
  int selectedIndex = 0;
  SelectionBloc() : super(SelectionInitial());

  @override
  Stream<SelectionState> mapEventToState(SelectionEvent event) async* {
    if (event is PageChangedEvent) {
      selectedIndex = event.index;
      yield PageChangedState(event.index);
    } else if (event is SelectionChangedEvent) {
      selectedIndex = event.index;
      yield SelectionChangedState(event.index);
    }
  }
}
