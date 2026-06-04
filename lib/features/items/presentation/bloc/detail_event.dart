part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCharacterDetail extends DetailEvent {
  final int id;
  LoadCharacterDetail(this.id);

  @override
  List<Object?> get props => [id];
}
