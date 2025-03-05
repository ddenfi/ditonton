import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:movie/blocs/movie_watchlist_status/movie_watchlist_status_cubit.dart';
import 'package:movie/blocs/recommended_movies/recommended_movies_cubit.dart';
import 'package:movie/pages/movie_detail_page.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks(
    [MovieDetailCubit, MovieWatchlistStatusCubit, RecommendedMoviesCubit])
void main() {
  late MockMovieDetailCubit mockMovieDetailCubit;
  late MockMovieWatchlistStatusCubit mockMovieWatchlistStatusCubit;
  late MockRecommendedMoviesCubit mockRecommendedMoviesCubit;

  setUp(() {
    mockMovieDetailCubit = MockMovieDetailCubit();
    mockMovieWatchlistStatusCubit = MockMovieWatchlistStatusCubit();
    mockRecommendedMoviesCubit = MockRecommendedMoviesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailCubit>.value(value: mockMovieDetailCubit),
        BlocProvider<MovieWatchlistStatusCubit>.value(
            value: mockMovieWatchlistStatusCubit),
        BlocProvider<RecommendedMoviesCubit>.value(
            value: mockRecommendedMoviesCubit),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    //provide dummy
    provideDummy<MovieDetailState>(
        MovieDetailSuccess(movieDetail: testMovieDetail));
    provideDummy<MovieWatchlistStatusState>(
        MovieWatchlistStatus(isAddedToWatchlist: false));
    provideDummy<RecommendedMoviesState>(
        RecommendedMoviesStateSuccess(data: []));

    // Mocking the Cubit states
    when(mockMovieDetailCubit.state)
        .thenReturn(MovieDetailSuccess(movieDetail: testMovieDetail));
    when(mockMovieDetailCubit.stream).thenAnswer(
      (_) => Stream.value(MovieDetailSuccess(movieDetail: testMovieDetail)),
    );

    when(mockMovieWatchlistStatusCubit.state)
        .thenReturn(MovieWatchlistStatus(isAddedToWatchlist: false));
    when(mockMovieWatchlistStatusCubit.stream).thenAnswer(
      (_) => Stream.value(MovieWatchlistStatus(isAddedToWatchlist: false)),
    );

    when(mockRecommendedMoviesCubit.state)
        .thenReturn(RecommendedMoviesStateSuccess(data: []));
    when(mockRecommendedMoviesCubit.stream).thenAnswer(
      (_) => Stream.value(RecommendedMoviesStateSuccess(data: [])),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    // Pump the widget with the BlocProvider setup
    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

    // Assert that the watchlist button has the 'add' icon
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
        //provide dummy
        provideDummy<MovieDetailState>(
            MovieDetailSuccess(movieDetail: testMovieDetail));
        provideDummy<MovieWatchlistStatusState>(
            MovieWatchlistStatus(isAddedToWatchlist: true));
        provideDummy<RecommendedMoviesState>(
            RecommendedMoviesStateSuccess(data: []));

        // Mocking the Cubit states
        when(mockMovieDetailCubit.state)
            .thenReturn(MovieDetailSuccess(movieDetail: testMovieDetail));
        when(mockMovieDetailCubit.stream).thenAnswer(
              (_) => Stream.value(MovieDetailSuccess(movieDetail: testMovieDetail)),
        );

        when(mockMovieWatchlistStatusCubit.state)
            .thenReturn(MovieWatchlistStatus(isAddedToWatchlist: true));
        when(mockMovieWatchlistStatusCubit.stream).thenAnswer(
              (_) => Stream.value(MovieWatchlistStatus(isAddedToWatchlist: true)),
        );

        when(mockRecommendedMoviesCubit.state)
            .thenReturn(RecommendedMoviesStateSuccess(data: []));
        when(mockRecommendedMoviesCubit.stream).thenAnswer(
              (_) => Stream.value(RecommendedMoviesStateSuccess(data: [])),
        );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
        //provide dummy
        provideDummy<MovieDetailState>(
            MovieDetailSuccess(movieDetail: testMovieDetail));
        provideDummy<MovieWatchlistStatusState>(
            MovieWatchlistStatus(isAddedToWatchlist: false));
        provideDummy<RecommendedMoviesState>(
            RecommendedMoviesStateSuccess(data: []));

        // Mocking the Cubit states
        when(mockMovieDetailCubit.state)
            .thenReturn(MovieDetailSuccess(movieDetail: testMovieDetail));
        when(mockMovieDetailCubit.stream).thenAnswer(
              (_) => Stream.value(MovieDetailSuccess(movieDetail: testMovieDetail)),
        );

        when(mockMovieWatchlistStatusCubit.state)
            .thenReturn(MovieWatchlistStatus(isAddedToWatchlist: false));
        when(mockMovieWatchlistStatusCubit.stream).thenAnswer(
              (_) => Stream.value(MovieWatchlistStatus(isAddedToWatchlist: false)),
        );

        when(mockRecommendedMoviesCubit.state)
            .thenReturn(RecommendedMoviesStateSuccess(data: []));
        when(mockRecommendedMoviesCubit.stream).thenAnswer(
              (_) => Stream.value(RecommendedMoviesStateSuccess(data: [])),
        );
    when(mockMovieWatchlistStatusCubit.watchlistMessage)
        .thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(FilledButton);

    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
        //provide dummy
        provideDummy<MovieDetailState>(
            MovieDetailSuccess(movieDetail: testMovieDetail));
        provideDummy<MovieWatchlistStatusState>(
            MovieWatchlistStatus(isAddedToWatchlist: false));
        provideDummy<RecommendedMoviesState>(
            RecommendedMoviesStateSuccess(data: []));

        // Mocking the Cubit states
        when(mockMovieDetailCubit.state)
            .thenReturn(MovieDetailSuccess(movieDetail: testMovieDetail));
        when(mockMovieDetailCubit.stream).thenAnswer(
              (_) => Stream.value(MovieDetailSuccess(movieDetail: testMovieDetail)),
        );

        when(mockMovieWatchlistStatusCubit.state)
            .thenReturn(MovieWatchlistStatus(isAddedToWatchlist: false));
        when(mockMovieWatchlistStatusCubit.stream).thenAnswer(
              (_) => Stream.value(MovieWatchlistStatus(isAddedToWatchlist: false)),
        );

        when(mockRecommendedMoviesCubit.state)
            .thenReturn(RecommendedMoviesStateSuccess(data: []));
        when(mockRecommendedMoviesCubit.stream).thenAnswer(
              (_) => Stream.value(RecommendedMoviesStateSuccess(data: [])),
        );
    when(mockMovieWatchlistStatusCubit.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(FilledButton);

    await tester.pumpWidget(makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
