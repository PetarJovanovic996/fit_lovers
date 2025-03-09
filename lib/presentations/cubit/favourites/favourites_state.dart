part of 'favourites_cubit.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();
}

class FavouritesInitial extends FavouritesState {
  @override
  List<Object> get props => [];
}

class FavouritesLoading extends FavouritesState {
  @override
  List<Object> get props => [];
}

class FavouritesLoaded extends FavouritesState {
  const FavouritesLoaded(this.favourites);
  final List<String> favourites;
  @override
  List<Object?> get props => [favourites];
}

class FavouritesError extends FavouritesState {
  const FavouritesError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
