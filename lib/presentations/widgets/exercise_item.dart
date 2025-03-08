import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/data/models/exercise.dart';
import 'package:fit_lovers/presentations/cubit/exercises/single_exercise_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({required this.exercise, super.key});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<SingleExerciseCubit>()
            .fetchSingleExercises(exercise.name!);
        Navigator.of(context).pushNamed(
          Routes.singleExerciseScreen,
        );
      },
      child: Card(
        color: const Color.fromARGB(255, 241, 238, 238),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text(exercise.type!)),
              Center(child: Text(exercise.difficulty!)),
              const SizedBox(
                height: 12,
              ),
              Text(
                exercise.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(exercise.muscle!),
              const SizedBox(
                height: 6,
              ),
              Text(exercise.equipment!),
              const SizedBox(
                height: 6,
              ),
              Text(
                '${AppLocalizations.of(context)!.instructions}: ${exercise.instructions}',
                style: const TextStyle(
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
