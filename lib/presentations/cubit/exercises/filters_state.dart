part of 'filters_cubit.dart';

enum ExerciseType {
  cardio,
  olympic_weightlifting,
  plyometrics,
  powerlifting,
  strength,
  stretching,
  strongman;

  String get getScreenName => capitalizeEachWord(name.replaceAll('_', ' '));
}

String capitalizeEachWord(String text) {
  if (text.isEmpty) return text;
  return text.split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }).join(' ');
}

class FiltersState extends Equatable {
  const FiltersState({this.type, this.searchByName});

  final ExerciseType? type;
  final String? searchByName;

  @override
  List<Object?> get props => [type, searchByName];

  FiltersState copyWith({
    ExerciseType? type,
    String? searchByName,
  }) {
    return FiltersState(
        type: type ?? this.type,
        searchByName: searchByName ?? this.searchByName);
  }
}
