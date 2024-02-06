import 'package:flix_id/domain/entity/movie/movie_detail.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> movieShortInfo({
  required AsyncValue<MovieDetail?> asyncMovieDetail,
  required BuildContext context,
}) =>
    [
      Row(
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset('assets/duration.png'),
          ),
          horizontalSpace(5),
          SizedBox(
            width: 95,
            child: Text(
              '${asyncMovieDetail.when(
                data: (movieDetail) =>
                    movieDetail != null ? movieDetail.runtime.toString() : '-',
                error: (error, stackTrace) => '-',
                loading: () => ' Loading',
              )} minutes',
              style: whiteTextStyle.copyWith(fontSize: 12, fontWeight: light),
            ),
          ),
          SizedBox(
            width: 14,
            height: 14,
            child: Image.asset('assets/genre.png'),
          ),
          horizontalSpace(5),
          SizedBox(
            width:
                MediaQuery.of(context).size.width - 48 - 95 - 14 - 14 - 5 - 5,
            height: 14,
            child: asyncMovieDetail.when(
              data: (movieDetail) {
                String genres = movieDetail?.genres.join(', ') ?? '-';

                return Text(
                  genres,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light,
                  ),
                );
              },
              error: (error, _) {
                return Text(
                  error.toString(),
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                  ),
                );
              },
              loading: () => Text(
                '-',
                style: whiteTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ),
          ),
          horizontalSpace(5),
        ],
      ),
    ];
