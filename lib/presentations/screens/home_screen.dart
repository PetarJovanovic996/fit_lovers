import 'package:fit_lovers/presentations/cubit/exercises/exercise_cubit.dart';
import 'package:fit_lovers/presentations/cubit/exercises/filters_cubit.dart';
import 'package:fit_lovers/presentations/screens/home_screen_tabs/favourites_tab_content.dart';
import 'package:fit_lovers/presentations/screens/home_screen_tabs/home_tab_content.dart';
import 'package:fit_lovers/presentations/screens/home_screen_tabs/profile_tab_content.dart';
import 'package:fit_lovers/presentations/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onTabSelected(
    int index,
    BuildContext context,
  ) {
    if (index == 0) {
      // Ensure the lists displays all exercises, when landing on home tab,
      // and the filters are cleared
      context.read<ExerciseCubit>().fetchAllExercises();
      context.read<FiltersCubit>().clearFilters();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.homeScreen,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _tabContent(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) => _onTabSelected(index, context),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: AppLocalizations.of(context)!.favorites,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
    );
  }
}

Widget _tabContent(int index) {
  switch (index) {
    case 0:
      return const HomeTabContent();
    case 1:
      return const FavouritesTabContent();
    case 2:
      return const ProfileTabContent();
    default:
      return const HomeTabContent();
  }
}
