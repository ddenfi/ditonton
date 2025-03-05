import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/pages/about_page.dart';
import 'package:movie/pages/home_movie_page.dart';
import 'package:movie/pages/search_page.dart';
import 'package:movie/pages/watchlist_movies_page.dart';
import 'package:tv/pages/home_tv_series_page.dart';
import 'package:tv/pages/tv_series_search_page.dart';
import 'package:tv/pages/tv_series_watchlist_page.dart';

import '../bloc/home_page/home_page_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
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
                    Navigator.pop(context);
                    context
                        .read<HomePageCubit>()
                        .updateDrawerState(HomeMoviePage.ROUTE_NAME);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.tv),
                  title: Text('TV Series'),
                  onTap: () {
                    Navigator.pop(context);
                    context
                        .read<HomePageCubit>()
                        .updateDrawerState(HomeTvSeriesPage.ROUTE_NAME);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.save_alt),
                  title: Text('Watchlist'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, WatchlistMoviesPage.ROUTE_NAME);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.save_alt),
                  title: Text('Tv-Series Watchlist'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, TvSeriesWatchlistPage.ROUTE_NAME);
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
            title: state.activeDrawerPage == HomeMoviePage.ROUTE_NAME
                ? Text("Ditonton Movies")
                : Text("Ditonton TV Series"),
            actions: [
              IconButton(
                onPressed: () {
                  if (state.activeDrawerPage == HomeMoviePage.ROUTE_NAME) {
                    Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
                  } else {
                    Navigator.pushNamed(context, TvSeriesSearchPage.ROUTE_NAME);
                  }
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          body: state.activeDrawerPage == HomeMoviePage.ROUTE_NAME
              ? HomeMoviePage()
              : HomeTvSeriesPage(),
        );
      },
    );
  }
}