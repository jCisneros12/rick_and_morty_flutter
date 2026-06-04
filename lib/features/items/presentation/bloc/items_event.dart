part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCharacters extends ItemsEvent {
  final int page;
  LoadCharacters({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class LoadMoreCharacters extends ItemsEvent {}

class RefreshCharacters extends ItemsEvent {}
