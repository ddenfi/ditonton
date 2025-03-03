import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_popular/tv_series_popular_cubit.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_popular_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series/popular';

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TvSeriesPopularCubit>().fetchPopularTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesPopularCubit, TvSeriesPopularState>(
          builder: (context, state) {
            switch (state) {
              case TvSeriesPopularInitial():
                return SizedBox();
              case TvSeriesPopularStateLoading():
                return Center(
                  child: CircularProgressIndicator(),
                );
              case TvSeriesPopularStateError():
                return Center(
                  key: Key('error_message'),
                  child: Text(state.message),
                );
              case TvSeriesPopularStateSuccess():
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
