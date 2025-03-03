import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_search/tv_series_search_cubit.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TvSeriesSearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/tv-series/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<TvSeriesSearchCubit>().fetchSearchTvSeries(query);
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<TvSeriesSearchCubit, TvSeriesSearchState>(
              builder: (context, state) {
                switch (state) {
                  case TvSeriesSearchInitial():
                    return SizedBox();
                  case TvSeriesSearchStateLoading():
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case TvSeriesSearchStateError():
                    // TODO add error message
                    return Expanded(
                      child: Container(),
                    );
                  case TvSeriesSearchStateSuccess():
                    final result = state.data;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final show = state.data[index];
                          return TvSeriesCardList(show);
                        },
                        itemCount: result.length,
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
