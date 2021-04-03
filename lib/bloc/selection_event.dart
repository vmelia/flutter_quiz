part of 'selection_bloc.dart';

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