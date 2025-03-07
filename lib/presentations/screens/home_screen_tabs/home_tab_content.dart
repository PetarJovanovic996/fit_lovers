import 'package:fit_lovers/presentations/cubit/exercises/exercise_cubit.dart';
import 'package:fit_lovers/presentations/cubit/exercises/filters_cubit.dart';
import 'package:fit_lovers/presentations/widgets/exercise_item.dart';
import 'package:fit_lovers/presentations/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTabContent extends StatelessWidget {
  const HomeTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _Filters(),
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
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<FiltersCubit, FiltersState>(
        builder: (context, state) {
          return Column(
            children: [
              _TypeFilter(),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                onChanged: (value) {
                  context.read<FiltersCubit>().searchByName(value);
                  context.read<ExerciseCubit>().fetchFilteredExercises(
                        name: state.searchByName,
                      );
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.searchExercises,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(
                height: 24,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TypeFilter extends StatelessWidget {
  const _TypeFilter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersCubit, FiltersState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<FiltersCubit>().selectType(ExerciseType.cardio);
                  context.read<ExerciseCubit>().fetchFilteredExercises(
                        type: state.type.toString().split('.').last,
                      );
                },
                child: Text(
                  'Cardio',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<FiltersCubit>()
                      .selectType(ExerciseType.olympic_weightlifting);
                  context.read<ExerciseCubit>().fetchFilteredExercises(
                        type: state.type.toString().split('.').last,
                      );
                },
                child: Text(
                  'Olympic Weightlifting',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<FiltersCubit>()
                      .selectType(ExerciseType.plyometrics);
                  context.read<ExerciseCubit>().fetchFilteredExercises(
                        type: state.type.toString().split('.').last,
                      );
                },
                child: Text(
                  'Plyometrics',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<FiltersCubit>()
                      .selectType(ExerciseType.powerlifting);
                  context.read<ExerciseCubit>().fetchFilteredExercises(
                        type: state.type.toString().split('.').last,
                      );
                },
                child: Text(
                  'Powerlifting',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<FiltersCubit>()
                      .selectType(ExerciseType.strength);
                  context.read<ExerciseCubit>().fetchFilteredExercises(
                        type: state.type.toString().split('.').last,
                      );
                },
                child: Text(
                  'Strenght',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<FiltersCubit>()
                      .selectType(ExerciseType.stretching);
                  context.read<ExerciseCubit>().fetchFilteredExercises(
                        type: state.type.toString().split('.').last,
                      );
                },
                child: Text(
                  'Stretching',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<FiltersCubit>()
                      .selectType(ExerciseType.strongman);
                  context.read<ExerciseCubit>().fetchFilteredExercises(
                        type: state.type.toString().split('.').last,
                      );
                },
                child: Text(
                  'Strongman',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
