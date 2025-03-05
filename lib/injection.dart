import 'package:core/data/datasources/api_client/tmdb_api_client.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_series_local_data_source.dart';
import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/domain/usecases/search_movies.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series_status.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:core/domain/usecases/tv_series/search_tv_series.dart';
import 'package:core/presentation/bloc/home_page/home_page_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:movie/blocs/movie_watchlist/movie_watchlist_cubit.dart';
import 'package:movie/blocs/movie_watchlist_status/movie_watchlist_status_cubit.dart';
import 'package:movie/blocs/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movie/blocs/popular_movies/popular_movies_cubit.dart';
import 'package:movie/blocs/recommended_movies/recommended_movies_cubit.dart';
import 'package:movie/blocs/search_movies/search_movies_cubit.dart';
import 'package:movie/blocs/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:tv/blocs/tv_series_detail/tv_series_detail_cubit.dart';
import 'package:tv/blocs/tv_series_now_playing/tv_series_now_playing_cubit.dart';
import 'package:tv/blocs/tv_series_popular/tv_series_popular_cubit.dart';
import 'package:tv/blocs/tv_series_recommended/tv_series_recommended_cubit.dart';
import 'package:tv/blocs/tv_series_search/tv_series_search_cubit.dart';
import 'package:tv/blocs/tv_series_top_rated/tv_series_top_rated_cubit.dart';
import 'package:tv/blocs/tv_series_watchlist/tv_series_watchlist_cubit.dart';
import 'package:tv/blocs/tv_series_watchlist_status/tv_series_watchlist_status_cubit.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => HomePageCubit(),
  );

  // Bloc
  locator.registerFactory(
    () => MovieDetailCubit(getMovieDetail: locator()),
  );

  locator.registerFactory(
    () => MovieWatchlistCubit(getWatchlistMovies: locator()),
  );

  locator.registerFactory(
    () => MovieWatchlistStatusCubit(locator(), locator(), locator()),
  );

  locator.registerFactory(
    () => NowPlayingMoviesCubit(locator()),
  );

  locator.registerFactory(
    () => PopularMoviesCubit(locator()),
  );

  locator.registerFactory(
    () => RecommendedMoviesCubit(locator()),
  );

  locator.registerFactory(
    () => SearchMoviesCubit(locator()),
  );

  locator.registerFactory(
    () => TopRatedMoviesCubit(locator()),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // CORE
  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton<http.Client>(() => TheMovieDbApiClient());

  // TV SERIES

  // Bloc
  locator.registerFactory(
    () => TvSeriesDetailCubit(locator()),
  );

  locator.registerFactory(
    () => TvSeriesNowPlayingCubit(locator()),
  );

  locator.registerFactory(
    () => TvSeriesPopularCubit(locator()),
  );

  locator.registerFactory(
    () => TvSeriesRecommendedCubit(locator()),
  );

  locator.registerFactory(
    () => TvSeriesSearchCubit(locator()),
  );

  locator.registerFactory(
    () => TvSeriesTopRatedCubit(locator()),
  );

  locator.registerFactory(
    () => TvSeriesWatchlistCubit(locator()),
  );

  locator.registerFactory(
    () => TvSeriesWatchlistStatusCubit(locator(), locator(), locator()),
  );

  // Use Case
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<TvSeriesRepositories>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));
}
