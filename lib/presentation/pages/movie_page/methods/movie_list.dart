import 'package:flix_id/domain/entity/movie/movie.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/widgets/card/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> movieList({
  required String title,
  void Function(Movie movie)? onTap,
  required AsyncValue<List<Movie>> movies,
}) =>
    [
      Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 15),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
      ),
      SizedBox(
        height: 220,
        child: movies.when(
          data: (data) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: data
                  .map(
                    (movie) => Padding(
                      padding: EdgeInsets.only(
                        left: movie == data.first ? 24 : 10,
                        right: movie == data.last ? 24 : 0,
                      ),
                      child: NetworkImageCard(
                        imageUrl: '${dotenv.env['TMDB_IMG_BASE_URL']}'
                            '${movie.posterPath}',
                        fit: BoxFit.contain,
                        onTap: () => onTap?.call(movie),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: whiteTextStyle,
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    ];
