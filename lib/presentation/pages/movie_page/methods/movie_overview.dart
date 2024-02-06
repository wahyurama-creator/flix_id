import 'package:flix_id/domain/entity/movie/movie_detail.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> movieOverview(AsyncValue<MovieDetail?> asyncMovieDetail) => [
      Text(
        'Overview',
        style: whiteTextStyle.copyWith(
          fontSize: 16,
          fontWeight: bold,
        ),
      ),
      verticalSpace(10),
      asyncMovieDetail.when(
        data: (movieDetail) =>
            Text(movieDetail != null ? movieDetail.overview : ''),
        error: (error, _) => Text(
          'Failed to load movie overview',
          style: whiteTextStyle.copyWith(
            fontSize: 12,
          ),
        ),
        loading: () => const CircularProgressIndicator(),
      ),
    ];
