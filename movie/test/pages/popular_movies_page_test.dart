import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/blocs/popular_movies/popular_movies_cubit.dart';
import 'package:movie/pages/popular_movies_page.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesCubit])
void main() {
  late MockPopularMoviesCubit mockCubit;

  setUp(() {
    mockCubit = MockPopularMoviesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    provideDummy<PopularMoviesState>(PopularMoviesLoading());

    when(mockCubit.state).thenReturn(PopularMoviesLoading());
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(PopularMoviesLoading()),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    provideDummy<PopularMoviesState>(PopularMoviesSuccess(data: testMovieList));

    when(mockCubit.state).thenReturn(PopularMoviesSuccess(data: testMovieList));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(PopularMoviesSuccess(data: testMovieList)),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    provideDummy<PopularMoviesState>(PopularMoviesError(message: "Failed"));

    when(mockCubit.state).thenReturn(PopularMoviesError(message: "Failed"));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.value(PopularMoviesError(message: "Failed")),
    );
    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
