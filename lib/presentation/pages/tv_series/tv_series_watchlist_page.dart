import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_watchlist/tv_series_watchlist_cubit.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_watchlist_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TvSeriesWatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series/watchlist';

  @override
  _TvSeriesWatchlistPageState createState() => _TvSeriesWatchlistPageState();
}

class _TvSeriesWatchlistPageState extends State<TvSeriesWatchlistPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TvSeriesWatchlistCubit>().fetchWatchlistTvSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<TvSeriesWatchlistCubit>().fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Series Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesWatchlistCubit, TvSeriesWatchlistState>(
          builder: (context, state) {
            switch (state) {
              case TvSeriesWatchlistInitial():
              return SizedBox();
              case TvSeriesWatchlistLoading():
                return Center(
                  child: CircularProgressIndicator(),
                );
              case TvSeriesWatchlistError():
                return Center(
                  key: Key('error_message'),
                  child: Text(state.message),
                );
              case TvSeriesWatchlistSuccess():
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvSeries = state.tvSeries[index];
                    return TvSeriesCardList(tvSeries);
                  },
                  itemCount: state.tvSeries.length,
                );

            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
