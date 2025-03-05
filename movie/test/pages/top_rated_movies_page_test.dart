import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/blocs/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movie/pages/top_rated_movies_page.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesCubit])
void main() {
  late MockTopRatedMoviesCubit mockCubit;

  setUp(() {
    mockCubit = MockTopRatedMoviesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    provideDummy<TopRatedMoviesState>(TopRatedMoviesLoading());

    when(mockCubit.state).thenReturn(TopRatedMoviesLoading());
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMoviesLoading()));

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    provideDummy<TopRatedMoviesState>(
        TopRatedMoviesSuccess(data: testMovieList));

    when(mockCubit.state)
        .thenReturn(TopRatedMoviesSuccess(data: testMovieList));
    when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(TopRatedMoviesSuccess(data: testMovieList)));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    provideDummy<TopRatedMoviesState>(TopRatedMoviesError(message: "Failed"));

    when(mockCubit.state).thenReturn(TopRatedMoviesError(message: "Failed"));
    when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(TopRatedMoviesError(message: "Failed")));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
