// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      muscles: json['muscles'] as String,
      equipment: json['equipment'] as String,
      difficulty: json['difficulty'] as String,
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
      'muscles': instance.muscles,
      'equipment': instance.equipment,
      'difficulty': instance.difficulty,
    };
