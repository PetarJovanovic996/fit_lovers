import 'package:fit_lovers/presentations/cubit/home_screen/cubit/home_screen_cubit.dart';
import 'package:fit_lovers/presentations/cubit/home_screen/cubit/home_screen_state.dart';
import 'package:fit_lovers/presentations/screens/home_screen_tabs/favourites_tab_content.dart';
import 'package:fit_lovers/presentations/screens/home_screen_tabs/home_tab_content.dart';
import 'package:fit_lovers/presentations/screens/home_screen_tabs/profile_tab_content.dart';
import 'package:fit_lovers/presentations/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.homeScreen,
      ),
      body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _tabContent(state.selectedTab),
                  // if (state.selectedTab == HomeScreenTab.home) HomeTabContent(),
                  // if (state.selectedTab == HomeScreenTab.favourites)
                  //   FavouritesTabContent(),
                  // if (state.selectedTab == HomeScreenTab.profile)
                  //   ProfileTabContent(),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.selectedTab.index,
            onTap: (index) {
              context
                  .read<HomeScreenCubit>()
                  .changeTab(HomeScreenTab.values[index]);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: AppLocalizations.of(context)!.favorites,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _tabContent(HomeScreenTab tab) {
    switch (tab) {
      case HomeScreenTab.home:
        return HomeTabContent();
      case HomeScreenTab.favourites:
        return FavouritesTabContent();
      case HomeScreenTab.profile:
        return ProfileTabContent();
    }
  }
}
