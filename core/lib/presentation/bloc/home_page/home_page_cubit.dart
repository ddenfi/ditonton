import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/home_movie_page.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState());

  void updateDrawerState(String routeName) {
    emit(HomePageState(activeDrawerPage: routeName));
  }
}
