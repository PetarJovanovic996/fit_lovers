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
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          _Filters(),
          ExercisesContent(),
        ],
      ),
    );
  }
}

class ExercisesContent extends StatelessWidget {
  const ExercisesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ExerciseCubit, ExerciseState>(
        builder: (context, state) {
          if (state is ExerciseLoading) {
            return const LoadingWidget();
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
              const _TypeFilter(),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  const SearchField(),
                  IconButton(
                      onPressed: () {
                        context
                            .read<ExerciseCubit>()
                            .fetchFilteredExercises(name: state.searchByName);
                      },
                      icon: const Icon(Icons.filter_list_rounded)),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          );
        },
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FiltersCubit, FiltersState>(
      listenWhen: (prev, curr) => prev.searchByName != curr.searchByName,
      listener: (context, state) {
        if (state.searchByName == null) {
          _controller.clear();
          FocusScope.of(context).unfocus();
        }
      },
      child: Expanded(
        child: TextFormField(
          controller: _controller,
          onChanged: (value) =>
              context.read<FiltersCubit>().searchByName(value),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.searchExercises,
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}

class _TypeFilter extends StatelessWidget {
  const _TypeFilter();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        scrollDirection: Axis.horizontal,
        itemCount: ExerciseType.values.length,
        itemBuilder: (context, index) => CustomFilterButton(
          type: ExerciseType.values[index],
        ),
      ),
    );
  }
}

class CustomFilterButton extends StatelessWidget {
  const CustomFilterButton({required this.type, super.key});

  final ExerciseType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersCubit, FiltersState>(
      buildWhen: (prev, curr) => prev.type != curr.type,
      builder: (context, state) {
        return ElevatedButton(
          style: ButtonStyle(
            side: WidgetStatePropertyAll(
              BorderSide(
                color: state.type == type ? Colors.blue : Colors.white,
              ),
            ),
          ),
          onPressed: () {
            context.read<FiltersCubit>().selectType(type);
            context.read<ExerciseCubit>().fetchFilteredExercises(
                  type: type.name,
                );
          },
          child: Text(
            type.getScreenName,
            style: const TextStyle(color: Colors.black),
          ),
        );
      },
    );
  }
}
