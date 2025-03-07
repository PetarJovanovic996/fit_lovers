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
                    onRefresh: () async {
                      context.read<FiltersCubit>().clearFilters();
                      await context.read<ExerciseCubit>().fetchAllExercises();
                    },
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
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: state.searchByName,

                      // s pecom:
                      // na reset ne micu se slova iz textformfield/a
                      onChanged: (value) {
                        context.read<FiltersCubit>().searchByName(value);
                      },

                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.searchExercises,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<ExerciseCubit>()
                            .fetchFilteredExercises(name: state.searchByName);
                      },
                      icon: Icon(Icons.filter_list_rounded)),
                ],
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
              _buildFilterButton(context, ExerciseType.cardio, 'Cardio'),
              _buildFilterButton(context, ExerciseType.olympic_weightlifting,
                  'Olympic Weightlifting'),
              _buildFilterButton(
                  context, ExerciseType.plyometrics, 'Plyometrics'),
              _buildFilterButton(
                  context, ExerciseType.powerlifting, 'Powerlifting'),
              _buildFilterButton(context, ExerciseType.strength, 'Strength'),
              _buildFilterButton(
                  context, ExerciseType.stretching, 'Stretching'),
              _buildFilterButton(context, ExerciseType.strongman, 'Strongman'),
            ],
          ),
        );
      },
    );
  }

  ElevatedButton _buildFilterButton(
      BuildContext context, ExerciseType type, String title) {
    return ElevatedButton(
      onPressed: () {
        context.read<FiltersCubit>().selectType(type);
        context.read<ExerciseCubit>().fetchFilteredExercises(
              type: type.toString().split('.').last,
            );
      },
      child: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
