import 'package:flix_id/domain/entity/movie/movie.dart';
import 'package:flix_id/domain/entity/movie/movie_detail.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/detail_page/methods/background.dart';
import 'package:flix_id/presentation/pages/detail_page/methods/cast_and_crew.dart';
import 'package:flix_id/presentation/pages/detail_page/methods/movie_short_info.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/movie_overview.dart';
import 'package:flix_id/presentation/providers/movie/movie_detail/movie_detail_provider.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/widgets/back_app_bar/back_app_bar.dart';
import 'package:flix_id/presentation/widgets/buttons/primary_button.dart';
import 'package:flix_id/presentation/widgets/card/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerWidget {
  final Movie movie;

  const DetailPage({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncMovieDetail = ref.watch(movieDetailProvider(movie: movie));

    return Scaffold(
      body: Stack(
        children: [
          ...background(movie),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackAppBar(
                      title: movie.title,
                      onTap: () {
                        ref.read(routerProvider).pop();
                      },
                    ),
                    verticalSpace(24),
                    NetworkImageCard(
                      width: MediaQuery.of(context).size.width - 48,
                      height: (MediaQuery.of(context).size.width - 48) * 0.6,
                      borderRadius: 15,
                      imageUrl: asyncMovieDetail.valueOrNull != null
                          ? '${dotenv.env['TMDB_IMG_BASE_URL']}'
                              '${asyncMovieDetail.valueOrNull?.backdropPath ?? movie.posterPath}'
                          : null,
                      fit: BoxFit.cover,
                    ),
                    verticalSpace(24),
                    ...movieShortInfo(
                      asyncMovieDetail: asyncMovieDetail,
                      context: context,
                    ),
                    verticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 14,
                          width: 15,
                          child: Image.asset('assets/star.png'),
                        ),
                        horizontalSpace(5),
                        Text(
                          (asyncMovieDetail.valueOrNull?.voteAverage ?? 0)
                              .toStringAsFixed(1),
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    ...movieOverview(asyncMovieDetail),
                    verticalSpace(40),
                  ],
                ),
              ),
              ...castAndCrew(movie: movie, ref: ref),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                child: PrimaryButton(
                  title: 'Book this Movie',
                  backgroundColor: saffronColor,
                  textColor: backgroundColor,
                  onPressed: () {
                    MovieDetail? movieDetail = asyncMovieDetail.valueOrNull;

                    if (movieDetail != null) {
                      ref.read(routerProvider).pushNamed(
                            'time-booking',
                            extra: movieDetail,
                          );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
