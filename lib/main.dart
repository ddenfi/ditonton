import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_cubit.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_status/movie_watchlist_status_cubit.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/recommended_movies/recommended_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/search_movies/search_movies_cubit.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_series/home_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_now_playing_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_search_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_watchlist_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'firebase_options.dart';
import 'presentation/bloc/tv_series/tv_series_detail/tv_series_detail_cubit.dart';
import 'presentation/bloc/tv_series/tv_series_now_playing/tv_series_now_playing_cubit.dart';
import 'presentation/bloc/tv_series/tv_series_popular/tv_series_popular_cubit.dart';
import 'presentation/bloc/tv_series/tv_series_recommended/tv_series_recommended_cubit.dart';
import 'presentation/bloc/tv_series/tv_series_search/tv_series_search_cubit.dart';
import 'presentation/bloc/tv_series/tv_series_top_rated/tv_series_top_rated_cubit.dart';
import 'presentation/bloc/tv_series/tv_series_watchlist/tv_series_watchlist_cubit.dart';
import 'presentation/bloc/tv_series/tv_series_watchlist_status/tv_series_watchlist_status_cubit.dart';

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
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
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
