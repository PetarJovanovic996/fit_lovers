import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/presentations/cubit/exercises/single_exercise_cubit.dart';
import 'package:fit_lovers/presentations/cubit/training%20circle/training_circle_cubit.dart';
import 'package:flutter/material.dart';

import 'package:fit_lovers/data/models/exercise.dart';
import 'package:fit_lovers/presentations/cubit/exercises/exercise_cubit.dart';
import 'package:fit_lovers/presentations/widgets/custom_app_bar.dart';
import 'package:fit_lovers/presentations/widgets/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrainingCircleScreen extends StatelessWidget {
  const TrainingCircleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.trainingCircle),
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/test.jpg"),
        //     fit: BoxFit.cover,
        //     invertColors: true,
        //     colorFilter: ColorFilter.mode(
        //       Color.fromARGB(255, 250, 248, 248),
        //       BlendMode.colorBurn,
        //     ),
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<ExerciseCubit, ExerciseState>(
            builder: (context, exerciseState) {
              return BlocBuilder<TrainingCircleCubit, TrainingCircleState>(
                builder: (context, state) {
                  if (state is TrainingCircleLoading ||
                      exerciseState is ExerciseLoading) {
                    return const LoadingWidget();
                  }

                  if (state is TrainingCircleLoaded &&
                      exerciseState is ExerciseLoaded) {
                    final allExercises = exerciseState.allExercises;

                    final trainingCircle = state.trainingCircle;

                    final trainingCircleExercises = allExercises
                        .where((exercise) =>
                            trainingCircle.contains(exercise.name))
                        .toList();

                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.trainingCircle.length,
                        itemBuilder: (context, index) => _TrainingCircleItems(
                          exercise: trainingCircleExercises[index],
                        ),
                      ),
                    );
                  }

                  if (state is TrainingCircleError) {
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

class _TrainingCircleItems extends StatelessWidget {
  const _TrainingCircleItems({required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              exercise.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                context
                    .read<SingleExerciseCubit>()
                    .fetchSingleExercises(exercise.name!);
                Navigator.of(context).pushNamed(
                  Routes.singleExerciseScreen,
                );
              },
              child: Text(
                AppLocalizations.of(context)!.seeDetails2,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
