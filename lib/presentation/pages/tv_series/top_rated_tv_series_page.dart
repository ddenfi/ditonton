import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_top_rated/tv_series_top_rated_cubit.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_top_rated_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series/top-rated';

  @override
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TvSeriesTopRatedCubit>().fetchTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesTopRatedCubit, TvSeriesTopRatedState>(
          builder: (context, state) {
            switch (state) {
              case TvSeriesTopRatedInitial():
                return SizedBox();
              case TvSeriesTopRatedStateLoading():
                return Center(
                  child: CircularProgressIndicator(),
                );
              case TvSeriesTopRatedStateError():
                return Center(
                  key: Key('error_message'),
                  child: Text(state.message),
                );
              case TvSeriesTopRatedStateSuccess():
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
