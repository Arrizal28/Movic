import 'package:flutter/material.dart';

class TvSeriesListPage extends StatefulWidget {
  static const ROUTE_NAME = "tv-series-list-page";

  const TvSeriesListPage({super.key});

  @override
  State<TvSeriesListPage> createState() => _TvSeriesListPageState();
}

class _TvSeriesListPageState extends State<TvSeriesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tv Series List"),
      ),
      body: Center(
        child: Text("Tv Series List"),
      ),
    );
  }
}
