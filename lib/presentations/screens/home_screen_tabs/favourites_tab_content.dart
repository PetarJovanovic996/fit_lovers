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
      child: BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          if (state is FavouritesLoading) {
            return const LoadingWidget();
          }

          if (state is FavouritesLoaded) {
            return ListView.builder(
              itemCount: state.favourites.length,
              itemBuilder: (context, index) {
                final exercise = state.favourites[index];

                return Center(
                  child: Text(
                    exercise,
                  ),
                );
              },
            );
          }

          if (state is FavouritesError) {
            return Center(child: Text(state.message));
          }

          return Container();
        },
      ),
    );
  }
}
