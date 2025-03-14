part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  final String activeDrawerPage;

  const HomePageState({this.activeDrawerPage = HomeMoviePage.ROUTE_NAME});

  @override
  List<Object?> get props => [activeDrawerPage];
}
