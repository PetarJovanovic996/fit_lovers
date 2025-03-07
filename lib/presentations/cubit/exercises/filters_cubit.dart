import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit() : super(FiltersState());

  void selectType(ExerciseType value) => emit(
        state.copywith(type: value),
      );

  void searchByName(String value) => emit(
        state.copywith(searchByName: value),
      );

  void clearFilters() {
    emit(FiltersState());
  }
}
