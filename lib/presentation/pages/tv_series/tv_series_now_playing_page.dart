import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_now_playing/tv_series_now_playing_cubit.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_now_playing_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_popular_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TvSeriesNowPlayingPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series/now-playing';

  @override
  _TvSeriesNowPlayingPageState createState() => _TvSeriesNowPlayingPageState();
}

class _TvSeriesNowPlayingPageState extends State<TvSeriesNowPlayingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TvSeriesNowPlayingCubit>().fetchNowPlayingTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesNowPlayingCubit, TvSeriesNowPlayingState>(
          builder: (context, state) {
            switch (state) {
              case TvSeriesNowPlayingInitial():
                return SizedBox();
              case TvSeriesNowPlayingStateLoading():
                return Center(
                  child: CircularProgressIndicator(),
                );
              case TvSeriesNowPlayingStateError():
                return Center(
                  key: Key('error_message'),
                  child: Text(state.message),
                );
              case TvSeriesNowPlayingStateSuccess():
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final show = state.data[index];
                    return TvSeriesCardList(show);
                  },
                  itemCount: state.data.length,
                );
            }
          },
        ),
      ),
    );
  }
}
