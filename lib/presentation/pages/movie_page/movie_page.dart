import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/movie_list.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/promotion_list.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/search_view.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/user_info.dart';
import 'package:flix_id/presentation/providers/movie/now_playing/now_playing_provider.dart';
import 'package:flix_id/presentation/providers/movie/up_coming/up_coming_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promotionImageFile = [
    'popcorn.jpg',
    'buy1get1.jpg',
  ];

  MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userInfo(ref),
            searchView(context),
            ...movieList(
              title: 'Now Playing',
              movies: ref.watch(nowPlayingProvider),
              onTap: (movie) {
                // TODO: Move to detail page
              },
            ),
            ...promotionList(promotionImageFile),
            ...movieList(
              title: 'Upcoming',
              movies: ref.watch(upComingProvider),
              onTap: (movie) {
                // TODO: Move to detail page
              },
            ),
            verticalSpace(100),
          ],
        ),
      ],
    );
  }
}
