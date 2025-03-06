import 'package:fit_lovers/data/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({required this.exercise, super.key});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: const Color.fromARGB(255, 232, 231, 231),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Column(
                children: [
                  Text(exercise.type!),
                  Text(exercise.difficulty!),
                ],
              )),
              SizedBox(
                height: 12,
              ),
              Text(
                exercise.name!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(exercise.muscle!),
              SizedBox(
                height: 6,
              ),
              Text(exercise.equipment!),
              SizedBox(
                height: 6,
              ),
              Text(
                '${AppLocalizations.of(context)!.instructions}: ${exercise.instructions}',
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
