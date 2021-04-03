part of 'selection_bloc.dart';

@immutable
abstract class SelectionEvent {}

abstract class PageChangedEvent extends SelectionEvent {}

class LeftPageChangedEvent extends PageChangedEvent {
  final int page;
  LeftPageChangedEvent(this.page);
}

class RightPageChangedEvent extends PageChangedEvent {
  final int page;
  RightPageChangedEvent(this.page);
}
