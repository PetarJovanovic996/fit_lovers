import 'package:bloc/bloc.dart';
import 'package:fit_lovers/presentations/cubit/home_screen/cubit/home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit()
      : super(HomeScreenState(
          selectedTab: HomeScreenTab.home,
        ));

  void changeTab(HomeScreenTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
}
