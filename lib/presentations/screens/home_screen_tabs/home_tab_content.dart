import 'package:fit_lovers/data/models/exercise.dart';
import 'package:fit_lovers/presentations/cubit/exercises/cubit/exercise_cubit.dart';
import 'package:fit_lovers/presentations/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabContent extends StatelessWidget {
  const HomeTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      builder: (context, state) {
        if (state is ExerciseLoading) {
          return LoadingWidget();
        }

        if (state is ExerciseLoaded) {
          return Expanded(
            child: ListView.builder(
                itemCount: state.exercises.length,
                itemBuilder: (context, index) => ExerciseItem(
                      exercise: state.exercises[index],
                    )),
          );
        }

        return Center(child: Text('No exercises available.'));
      },
    );
  }
}

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({required this.exercise, super.key});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(exercise.name!),
              SizedBox(
                height: 6,
              ),
              SizedBox(
                height: 10,
              ),
              //TODO: dodaju se svi elementi iz modela
              //TODO: Sredi cijeli UI / prevod i izgled

              Text(
                "Instructions: ${exercise.instructions}",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
