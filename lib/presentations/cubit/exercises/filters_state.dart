part of 'filters_cubit.dart';

enum ExerciseType {
  cardio,
  olympic_weightlifting,
  plyometrics,
  powerlifting,
  strength,
  stretching,
  strongman
}

class FiltersState extends Equatable {
  const FiltersState({this.type, this.searchByName});

  final ExerciseType? type;
  final String? searchByName;

  @override
  List<Object?> get props => [type, searchByName];

  FiltersState copywith({
    ExerciseType? type,
    String? searchByName,
  }) {
    return FiltersState(
        type: type ?? this.type,
        searchByName: searchByName ?? this.searchByName);
  }
}
