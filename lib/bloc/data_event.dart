part of 'data_bloc.dart';

@immutable
abstract class DataEvent {}

class LoadDataEvent extends DataEvent {
  final String assetPath;

  LoadDataEvent(this.assetPath);
}
