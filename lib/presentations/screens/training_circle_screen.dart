import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/presentations/cubit/exercises/single_exercise_cubit.dart';
import 'package:fit_lovers/presentations/cubit/training%20circle/training_circle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:fit_lovers/presentations/widgets/custom_app_bar.dart';
import 'package:fit_lovers/presentations/widgets/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrainingCircleScreen extends StatelessWidget {
  const TrainingCircleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.trainingCircle,
      ),
      body: BlocBuilder<TrainingCircleCubit, TrainingCircleState>(
        builder: (context, state) {
          if (state is TrainingCircleLoading) {
            return const LoadingWidget();
          }

          if (state is TrainingCircleLoaded) {
            final trainingCircle = state.trainingCircle;
            if (trainingCircle.isEmpty) {
              return Center(
                  child: Text(AppLocalizations.of(context)!.noTrainingsLeft));
            }
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/test2.jpg"),
                      fit: BoxFit.cover,
                      invertColors: true,
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 33, 26, 26),
                          BlendMode.hardLight))),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: trainingCircle.length,
                      itemBuilder: (context, index) {
                        final exercise = trainingCircle[index];
                        final exerciseName = exercise['exerciseName'];
                        final repetitionNumber =
                            exercise['repetitionNumber'].toString();
                        return TrainingCircleList(
                            exerciseName: exerciseName,
                            repetitionNumber: repetitionNumber);
                      },
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(10, 80)),
                      onPressed: () {
                        context
                            .read<TrainingCircleCubit>()
                            .removeTrainingCircle();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.deleteTrainingCircle,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                      )),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            );
          }

          if (state is TrainingCircleError) {
            return Center(child: Text(state.message));
          }

          return Container();
        },
      ),
    );
  }
}

class TrainingCircleList extends StatelessWidget {
  const TrainingCircleList({
    super.key,
    required this.exerciseName,
    required this.repetitionNumber,
  });

  final String exerciseName;
  final String repetitionNumber;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(exerciseName),
      subtitle: Text('x$repetitionNumber'),
      trailing: TextButton(
        child: Text(
          AppLocalizations.of(context)!.seeDetails2,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
        ),
        onPressed: () {
          context
              .read<SingleExerciseCubit>()
              .fetchSingleExercises(exerciseName);
          Navigator.of(context).pushNamed(
            Routes.singleExerciseScreen,
          );
        },
      ),
    );
  }
}
