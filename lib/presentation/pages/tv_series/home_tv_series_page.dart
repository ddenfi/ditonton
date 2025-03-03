import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_now_playing/tv_series_now_playing_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_popular/tv_series_popular_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_top_rated/tv_series_top_rated_cubit.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/tv_series/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_now_playing_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_search_page.dart';
import 'package:ditonton/presentation/pages/tv_series/tv_series_watchlist_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/home/tv-series';

  const HomeTvSeriesPage();

  @override
  State<HomeTvSeriesPage> createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<TvSeriesNowPlayingCubit>().fetchNowPlayingTvSeries();
      context.read<TvSeriesPopularCubit>().fetchPopularTvSeries();
      context.read<TvSeriesTopRatedCubit>().fetchTopRatedTvSeries();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
                backgroundColor: Colors.grey.shade900,
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, HomeTvSeriesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Tv-Series Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, TvSeriesWatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TvSeriesSearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () => Navigator.pushNamed(
                    context, TvSeriesNowPlayingPage.ROUTE_NAME),
              ),
              BlocBuilder<TvSeriesNowPlayingCubit, TvSeriesNowPlayingState>(
                builder: (context, state) {
                  switch (state) {
                    case TvSeriesNowPlayingInitial():
                      return SizedBox();
                    case TvSeriesNowPlayingStateLoading():
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case TvSeriesNowPlayingStateError():
                      return Text('Failed');
                    case TvSeriesNowPlayingStateSuccess():
                      return TvSeriesList(state.data);
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                    context, PopularTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvSeriesPopularCubit, TvSeriesPopularState>(
                builder: (context, state) {
                  switch (state) {
                    case TvSeriesPopularInitial():
                      return SizedBox();
                    case TvSeriesPopularStateLoading():
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case TvSeriesPopularStateError():
                      return Text('Failed');
                    case TvSeriesPopularStateSuccess():
                      return TvSeriesList(state.data);
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvSeriesTopRatedCubit, TvSeriesTopRatedState>(
                builder: (context, state) {
                  switch (state) {
                    case TvSeriesTopRatedInitial():
                      return SizedBox();
                    case TvSeriesTopRatedStateLoading():
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case TvSeriesTopRatedStateError():
                      return Text('Failed');
                    case TvSeriesTopRatedStateSuccess():
                      return TvSeriesList(state.data);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> shows;

  TvSeriesList(this.shows);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final show = shows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: show.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${show.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: shows.length,
      ),
    );
  }
}
