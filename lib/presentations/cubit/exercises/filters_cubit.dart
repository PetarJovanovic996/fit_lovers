import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit() : super(const FiltersState());

  void selectType(ExerciseType value) => emit(
        state.copyWith(type: value),
      );

  void searchByName(String value) => emit(
        state.copyWith(searchByName: value),
      );

  void clearFilters() {
    emit(const FiltersState());
  }
}
