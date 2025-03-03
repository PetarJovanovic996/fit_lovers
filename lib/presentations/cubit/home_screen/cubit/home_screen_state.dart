import 'package:equatable/equatable.dart';

enum HomeScreenTab { home, favourites, profile }

class HomeScreenState extends Equatable {
  const HomeScreenState({required this.selectedTab});
  final HomeScreenTab selectedTab;

  @override
  List<Object?> get props => [selectedTab];

  HomeScreenState copyWith({
    HomeScreenTab? selectedTab,
  }) {
    return HomeScreenState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}
