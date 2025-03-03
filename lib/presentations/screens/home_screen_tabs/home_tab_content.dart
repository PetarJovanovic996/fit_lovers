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
          return ListView.builder(
            itemCount: state.exercises.length,
            itemBuilder: (context, index) {
              final exercise = state.exercises[index];
              return ListTile(
                title: Text(exercise.name ?? exercise.muscles!),
              );
            },
          );
        }

        return Center(child: Text('No exercises available.'));
      },
    );
  }
}
