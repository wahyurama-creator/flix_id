import 'package:flix_id/domain/entity/movie/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

List<Widget> background(Movie movie) => [
      Image.network(
        '${dotenv.env['TMDB_IMG_BASE_URL']}${movie.posterPath}',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.4),
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(1),
            ],
          ),
        ),
      ),
    ];
