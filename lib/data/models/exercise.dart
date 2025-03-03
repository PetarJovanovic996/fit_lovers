import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

@JsonSerializable()
class Exercise {
  final String name;
  final String type;
  final String description;
  final String muscles;
  final String equipment;
  final String difficulty;

  Exercise({
    required this.name,
    required this.type,
    required this.description,
    required this.muscles,
    required this.equipment,
    required this.difficulty,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}
