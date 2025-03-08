import 'package:fit_lovers/presentations/cubit/exercises/single_exercise_cubit.dart';
import 'package:fit_lovers/presentations/widgets/custom_app_bar.dart';
import 'package:fit_lovers/presentations/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleExerciseScreen extends StatelessWidget {
  const SingleExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.seeDetails,
      ),
      body: BlocBuilder<SingleExerciseCubit, SingleExerciseState>(
        builder: (context, state) {
          if (state is SingleExerciseLoading) {
            return const LoadingWidget();
          }

          if (state is SingleExerciseLoaded) {
            final exercise = state.exercise;
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          exercise.type!,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        )),
                        Center(
                          child: Text(
                            exercise.difficulty!,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          exercise.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          exercise.muscle!,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          exercise.equipment!,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          '${AppLocalizations.of(context)!.instructions}: ${exercise.instructions}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ]),
                ],
              ),
            );
          }
          if (state is SingleExerciseError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
