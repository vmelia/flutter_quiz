part of 'data_bloc.dart';

@immutable
abstract class DataEvent {}

class LoadDataEvent extends DataEvent {
  LoadDataEvent(this.assetPath);

  final String assetPath;
}
