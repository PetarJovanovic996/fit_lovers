import 'package:fit_lovers/presentations/cubit/exercises/cubit/exercise_cubit.dart';
import 'package:fit_lovers/presentations/widgets/exercise_item.dart';
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

        if (state is ExerciseError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}
