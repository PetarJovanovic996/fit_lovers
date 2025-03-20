import 'package:fit_lovers/data/models/exercise.dart';
import 'package:fit_lovers/presentations/cubit/completed/completed_exercises_cubit.dart';
import 'package:fit_lovers/presentations/cubit/exercises/exercise_cubit.dart';
import 'package:fit_lovers/presentations/widgets/custom_app_bar.dart';
import 'package:fit_lovers/presentations/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompletedExercisesScreen extends StatelessWidget {
  const CompletedExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.completedExercises2),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/test.jpg"),
            fit: BoxFit.cover,
            invertColors: true,
            colorFilter: ColorFilter.mode(
              Color.fromARGB(255, 250, 248, 248),
              BlendMode.colorBurn,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<ExerciseCubit, ExerciseState>(
            builder: (context, exerciseState) {
              return BlocBuilder<CompletedExercisesCubit,
                  CompletedExercisesState>(
                builder: (context, state) {
                  if (state is CompletedExercisesLoading ||
                      exerciseState is ExerciseLoading) {
                    return const LoadingWidget();
                  }

                  if (state is CompletedExercisesLoaded &&
                      exerciseState is ExerciseLoaded) {
                    final allExercises = exerciseState.allExercises;

                    final completed = state.completed;

                    final completedExercises = allExercises
                        .where((exercise) => completed.contains(exercise.name))
                        .toList();

                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.completed.length,
                        itemBuilder: (context, index) => _CompletedExerciseItem(
                          exercise: completedExercises[index],
                        ),
                      ),
                    );
                  }

                  if (state is CompletedExercisesError) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CompletedExerciseItem extends StatelessWidget {
  const _CompletedExerciseItem({required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
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
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            context
                .read<CompletedExercisesCubit>()
                .removeCompleted(exercise.name!);
          },
          icon: const Icon(Icons.delete_forever),
        ),
      ],
    );
  }
}
