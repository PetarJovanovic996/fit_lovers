import 'package:fit_lovers/presentations/cubit/exercises/exercise_cubit.dart';
import 'package:fit_lovers/presentations/widgets/exercise_item.dart';
import 'package:fit_lovers/presentations/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTabContent extends StatelessWidget {
  const HomeTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            onChanged: (query) {
              context.read<ExerciseCubit>().searchExercises(query);
            },
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.searchExercises,
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<ExerciseCubit, ExerciseState>(
            builder: (context, state) {
              if (state is ExerciseLoading) {
                return LoadingWidget();
              }

              if (state is ExerciseLoaded) {
                return RefreshIndicator(
                  color: Colors.black,
                  onRefresh: () =>
                      context.read<ExerciseCubit>().fetchAllExercises(),
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
          ),
        ),
      ],
    );
  }
}
