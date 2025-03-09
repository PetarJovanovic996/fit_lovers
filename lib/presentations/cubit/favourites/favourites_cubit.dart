import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fit_lovers/data/repositories/user_repository.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  final UserRepository _userRepository;

  FavouritesCubit(this._userRepository) : super(FavouritesInitial());

  Future<void> loadFavourites() async {
    emit(FavouritesLoading());
    try {
      final favourites = await _userRepository.getFavourites();
      emit(FavouritesLoaded(favourites));
    } catch (e) {
      emit(FavouritesError(e.toString()));
    }
  }

  Future<void> toggleFavourite(String exerciseName) async {
    try {
      await _userRepository.toggleFavourite(exerciseName);
      final favourites = await _userRepository.getFavourites();
      emit(FavouritesLoaded(favourites));
    } catch (e) {
      emit(FavouritesError(e.toString()));
    }
  }
}
