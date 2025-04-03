import 'package:fit_lovers/data/models/exercise.dart';
import 'package:fit_lovers/presentations/cubit/completed/completed_exercises_cubit.dart';
import 'package:fit_lovers/presentations/cubit/exercises/single_exercise_cubit.dart';
import 'package:fit_lovers/presentations/cubit/training%20circle/training_circle_cubit.dart';
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
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/test2.jpg"),
                      fit: BoxFit.cover,
                      invertColors: true,
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 33, 26, 26),
                          BlendMode.hardLight))),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleExerciseContent(exercise: exercise),
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

class SingleExerciseContent extends StatelessWidget {
  const SingleExerciseContent({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
              child: Text(
            exercise.type!,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          )),
          Center(
            child: Text(
              exercise.difficulty!,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
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
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            exercise.muscle!,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            exercise.equipment!,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            '${AppLocalizations.of(context)!.instructions}: ${exercise.instructions}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          BlocBuilder<CompletedExercisesCubit, CompletedExercisesState>(
            builder: (context, state) {
              bool isCompleted = false;
              if (state is CompletedExercisesLoaded) {
                isCompleted = state.completed.contains(exercise.name);
              }

              return SingleExerciseContentButtons(
                  isCompleted: isCompleted, exercise: exercise);
            },
          ),
        ]),
      ],
    );
  }
}

class SingleExerciseContentButtons extends StatelessWidget {
  const SingleExerciseContentButtons({
    super.key,
    required this.isCompleted,
    required this.exercise,
  });

  final bool isCompleted;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CompleteTrainingButton(isCompleted: isCompleted, exercise: exercise),
        const SizedBox(
          height: 24,
        ),
        BlocBuilder<TrainingCircleCubit, TrainingCircleState>(
          builder: (context, state) {
            bool isSelected = false;
            if (state is TrainingCircleLoaded) {
              isSelected = state.trainingCircle.contains(exercise.name);
            }
            return TrainingCircleButton(
                isSelected: isSelected, exercise: exercise);
          },
        ),
      ],
    );
  }
}

class CompleteTrainingButton extends StatelessWidget {
  const CompleteTrainingButton({
    super.key,
    required this.isCompleted,
    required this.exercise,
  });

  final bool isCompleted;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isCompleted
          ? null
          : () {
              context
                  .read<CompletedExercisesCubit>()
                  .addCompleted(exercise.name!);
            },
      label: Text(
        AppLocalizations.of(context)!.completedExercises,
        style: const TextStyle(color: Colors.black, fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(1, 80),
      ),
      icon: const Icon(
        Icons.done,
        color: Colors.black,
      ),
    );
  }
}

class TrainingCircleButton extends StatelessWidget {
  const TrainingCircleButton({
    super.key,
    required this.isSelected,
    required this.exercise,
  });

  final bool isSelected;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isSelected
          ? null
          : () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AddRepetitonNumberWidget(
                      exercise: exercise,
                    );
                  });
            },
      label: Text(
        AppLocalizations.of(context)!.addTrainingCircle,
        style: const TextStyle(color: Colors.black, fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(1, 80),
      ),
      icon: const Icon(
        Icons.sports_gymnastics_sharp,
        color: Colors.black,
      ),
    );
  }
}

class AddRepetitonNumberWidget extends StatelessWidget {
  const AddRepetitonNumberWidget({super.key, required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    String repetitionNumber = '1';
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addRepetitionNumber),
      content: TextFormField(
        initialValue: repetitionNumber,
        keyboardType: const TextInputType.numberWithOptions(),
        autofocus: true,
        onChanged: (value) {
          repetitionNumber = value;
        },
        decoration: const InputDecoration(prefix: Text('x ')),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.back),
        ),
        TextButton(
          onPressed: () {
            final int repetitions = int.tryParse(repetitionNumber) ?? 1;
            context
                .read<TrainingCircleCubit>()
                .addTrainingCircle(exercise.name!, repetitions);

            Navigator.of(context).pop();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!
                      .succesfullAddedTrainingCircle),
                ),
              );
          },
          child: Text(AppLocalizations.of(context)!.addTrainingCircle),
        ),
      ],
    );
  }
}
