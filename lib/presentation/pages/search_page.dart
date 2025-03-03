import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/search_movies/search_movies_cubit.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

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
                context.read<SearchMoviesCubit>().fetchMovieSearch(query);
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
            BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
              builder: (context, state) {
                switch (state) {
                  case SearchMoviesInitial():
                    return SizedBox();
                  case SearchMoviesLoading():
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case SearchMoviesError():
                    return Expanded(
                      child: Container(),
                    );
                  case SearchMoviesSuccess():
                    final result = state.data;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final movie = state.data[index];
                          return MovieCard(movie);
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
