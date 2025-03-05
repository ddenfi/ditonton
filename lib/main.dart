import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:core/presentation/bloc/home_page/home_page_cubit.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:movie/blocs/movie_watchlist/movie_watchlist_cubit.dart';
import 'package:movie/blocs/movie_watchlist_status/movie_watchlist_status_cubit.dart';
import 'package:movie/blocs/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movie/blocs/popular_movies/popular_movies_cubit.dart';
import 'package:movie/blocs/recommended_movies/recommended_movies_cubit.dart';
import 'package:movie/blocs/search_movies/search_movies_cubit.dart';
import 'package:movie/blocs/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movie/pages/about_page.dart';
import 'package:movie/pages/home_movie_page.dart';
import 'package:movie/pages/movie_detail_page.dart';
import 'package:movie/pages/popular_movies_page.dart';
import 'package:movie/pages/search_page.dart';
import 'package:movie/pages/top_rated_movies_page.dart';
import 'package:movie/pages/watchlist_movies_page.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tv/blocs/tv_series_detail/tv_series_detail_cubit.dart';
import 'package:tv/blocs/tv_series_now_playing/tv_series_now_playing_cubit.dart';
import 'package:tv/blocs/tv_series_popular/tv_series_popular_cubit.dart';
import 'package:tv/blocs/tv_series_recommended/tv_series_recommended_cubit.dart';
import 'package:tv/blocs/tv_series_search/tv_series_search_cubit.dart';
import 'package:tv/blocs/tv_series_top_rated/tv_series_top_rated_cubit.dart';
import 'package:tv/blocs/tv_series_watchlist/tv_series_watchlist_cubit.dart';
import 'package:tv/blocs/tv_series_watchlist_status/tv_series_watchlist_status_cubit.dart';
import 'package:tv/pages/home_tv_series_page.dart';
import 'package:tv/pages/popular_tv_series_page.dart';
import 'package:tv/pages/top_rated_tv_series_page.dart';
import 'package:tv/pages/tv_series_detail_page.dart';
import 'package:tv/pages/tv_series_now_playing_page.dart';
import 'package:tv/pages/tv_series_search_page.dart';
import 'package:tv/pages/tv_series_watchlist_page.dart';

import 'firebase_options.dart';

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<HomePageCubit>(),
        ),
        //Movies
        BlocProvider(
          create: (_) => di.locator<MovieDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistStatusCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendedMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesCubit>(),
        ),
        // Tv Series
        BlocProvider(
          create: (_) => di.locator<TvSeriesDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesNowPlayingCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesPopularCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesRecommendedCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesSearchCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesTopRatedCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesWatchlistCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesWatchlistStatusCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            //TV-Series
            case HomeTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => HomeTvSeriesPage());
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (context) => TvSeriesDetailPage(id: id),
                  settings: settings);
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case TvSeriesSearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TvSeriesSearchPage());
            case TvSeriesWatchlistPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => TvSeriesWatchlistPage());
            case TvSeriesNowPlayingPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => TvSeriesNowPlayingPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
