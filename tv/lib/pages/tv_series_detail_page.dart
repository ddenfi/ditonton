import 'package:core/common/constants.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_series/tv_series_detail.dart';
import 'package:flutter/material.dart';
import 'package:tv/blocs/tv_series_detail/tv_series_detail_cubit.dart';
import 'package:tv/blocs/tv_series_recommended/tv_series_recommended_cubit.dart';
import 'package:tv/blocs/tv_series_watchlist_status/tv_series_watchlist_status_cubit.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail/tv-series';

  final int id;

  const TvSeriesDetailPage({super.key, required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesDetailCubit>().fetchTvSeriesDetail(widget.id);
      context
          .read<TvSeriesWatchlistStatusCubit>()
          .loadWatchlistStatus(widget.id);
      context
          .read<TvSeriesRecommendedCubit>()
          .fetchRecommendedTvSeries(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<TvSeriesDetailCubit, TvSeriesDetailState>(
      builder: (context, state) {
        switch (state) {
          case TvSeriesDetailInitial():
            return SizedBox();
          case TvSeriesDetailStateLoading():
            return Center(
              child: CircularProgressIndicator(),
            );
          case TvSeriesDetailStateError():
            return Text(state.message);
          case TvSeriesDetailStateSuccess():
            final show = state.data;
            return SafeArea(
              child: DetailContent(show),
            );
        }
      },
    ));
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail show;
  final String watchlistAddSuccessMessage = 'Added to Watchlist';
  final String watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  const DetailContent(this.show, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${show.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              show.name ?? "",
                              style: kHeading5,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BlocBuilder<TvSeriesWatchlistStatusCubit,
                                    TvSeriesWatchlistStatusState>(
                                  builder: (context, state) {
                                    return FilledButton(
                                      onPressed: () async {
                                        if (!state.isAddedToWatchlist) {
                                          await context
                                              .read<
                                                  TvSeriesWatchlistStatusCubit>()
                                              .addWatchlist(show);
                                        } else {
                                          await context
                                              .read<
                                                  TvSeriesWatchlistStatusCubit>()
                                              .removeFromWatchlist(show);
                                        }

                                        final message = context
                                            .read<
                                                TvSeriesWatchlistStatusCubit>()
                                            .watchlistMessage;

                                        if (message ==
                                                watchlistAddSuccessMessage ||
                                            message ==
                                                watchlistRemoveSuccessMessage) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(message)));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(message),
                                                );
                                              });
                                        }
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          state.isAddedToWatchlist
                                              ? Icon(Icons.check)
                                              : Icon(Icons.add),
                                          Text('Watchlist'),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.grey.shade400.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "Total Season",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            show.numberOfSeasons.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      VerticalDivider(
                                        color: Colors.black,
                                        thickness: 1,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Total Eps",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            show.numberOfEpisodes.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              _showGenres(show.genres ?? []),
                            ),
                            Text(
                              _showDuration((show.episodeRunTime?.length != 0)
                                  ? show.episodeRunTime?.first
                                  : 0),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: show.voteAverage ?? 0 / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${show.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              show.overview ?? "",
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvSeriesRecommendedCubit,
                                TvSeriesRecommendedState>(
                              builder: (context, state) {
                                switch (state) {
                                  case TvSeriesRecommendedInitial():
                                    return SizedBox();
                                  case TvSeriesRecommendedStateLoading():
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  case TvSeriesRecommendedStateError():
                                    return Text(state.message);
                                  case TvSeriesRecommendedStateSuccess():
                                    return SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final show = state.data[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  TvSeriesDetailPage.ROUTE_NAME,
                                                  arguments: show.id,
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://image.tmdb.org/t/p/w500${show.posterPath}',
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: state.data.length,
                                      ),
                                    );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int? runtime) {
    if (runtime == null) return "0m";
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
