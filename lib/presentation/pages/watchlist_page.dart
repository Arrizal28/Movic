import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';
import '../../common/utils.dart';
import '../provider/movie/watchlist_movie_notifier.dart';
import '../provider/tv/watchlist_tv_notifier.dart';
import '../widgets/movie_card_list.dart';
import '../widgets/tv_card.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  const WatchlistPage({super.key});

  @override
  State<StatefulWidget> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
            () {
          Provider.of<WatchlistMovieNotifier>(context, listen: false)
              .fetchWatchlistMovies();
          Provider.of<WatchlistTvNotifier>(context, listen: false)
              .fetchWatchlistTvSeries();
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(dividerColor: Colors.black, tabs: [
            Tab(text: "Movies"),
            Tab(text: "TV Series"),
          ]),
          title: const Text("Watchlist"),
        ),
        body: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<WatchlistMovieNotifier>(
              builder: (context, movieData, child) {
                return WatchlistContent(
                  state: movieData.watchlistState,
                  data: movieData.watchlistMovies,
                  itemBuilder: (item) =>
                      MovieCard(movie: item),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<WatchlistTvNotifier>(
              builder: (context, tvData, child) {
                return WatchlistContent(
                    state: tvData.watchlistTvState,
                    data: tvData.watchlistTvSeries,
                    itemBuilder: (item) =>
                        TvCard(tv: item)
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class WatchlistContent extends StatelessWidget {
  final RequestState state;
  final List data;
  final Widget Function(dynamic item) itemBuilder;

  const WatchlistContent(
      {super.key,
        required this.state,
        required this.data,
        required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    if (state == RequestState.Loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state == RequestState.Loaded) {
      return ListView.builder(
        itemBuilder: (context, index) => itemBuilder(data[index]),
        itemCount: data.length,
      );
    } else if (state == RequestState.Error) {
      return Center(
        key: const Key('error_message'),
        child: Text(state.name),
      );
    } else {
      return const Center();
    }
  }
}