import 'package:fit_lovers/presentations/cubit/exercises/exercise_cubit.dart';
import 'package:fit_lovers/presentations/widgets/exercise_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_lovers/presentations/cubit/favourites/favourites_cubit.dart';
import 'package:fit_lovers/presentations/widgets/loading_widget.dart';

class FavouritesTabContent extends StatelessWidget {
  const FavouritesTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<ExerciseCubit, ExerciseState>(
        builder: (context, exerciseState) {
          return BlocBuilder<FavouritesCubit, FavouritesState>(
            builder: (context, state) {
              if (state is FavouritesLoading ||
                  exerciseState is ExerciseLoading) {
                return const LoadingWidget();
              }

              if (state is FavouritesLoaded &&
                  exerciseState is ExerciseLoaded) {
                // Extract allExercises
                final allExercises = exerciseState.allExercises;

                // Extract favourites names
                final favourites = state.favourites;

                // Extract List<Exercises> objects, which have the "favourites" names
                final favouriteExercises = allExercises
                    .where((exercise) => favourites.contains(exercise.name))
                    .toList();

                return ListView.builder(
                  itemCount: state.favourites.length,
                  itemBuilder: (context, index) => ExerciseItem(
                    exercise: favouriteExercises[index],
                  ),
                );
              }

              if (state is FavouritesError) {
                return Center(child: Text(state.message));
              }

              return Container();
            },
          );
        },
      ),
    );
  }
}
