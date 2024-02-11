import 'dart:io';

import 'package:flix_id/domain/entity/movie/movie.dart';
import 'package:flix_id/domain/entity/movie/movie_detail.dart';
import 'package:flix_id/domain/entity/transaction/transaction.dart';
import 'package:flix_id/presentation/pages/booking_confirmation_page/booking_confirmation_page.dart';
import 'package:flix_id/presentation/pages/change_password_page/change_password_page.dart';
import 'package:flix_id/presentation/pages/detail_page/detail_page.dart';
import 'package:flix_id/presentation/pages/login_page/login_page.dart';
import 'package:flix_id/presentation/pages/main_page/main_page.dart';
import 'package:flix_id/presentation/pages/register_page/register_page.dart';
import 'package:flix_id/presentation/pages/seat_booking/seat_booking_page.dart';
import 'package:flix_id/presentation/pages/time_booking_page/time_booking_page.dart';
import 'package:flix_id/presentation/pages/update_profile_page/update_profile_page.dart';
import 'package:flix_id/presentation/pages/wallet_page/wallet_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(
      routes: [
        GoRoute(
          path: '/main',
          name: 'main',
          builder: (context, state) => MainPage(
            imageFile: state.extra != null ? state.extra as File : null,
          ),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: '/detail',
          name: 'detail',
          builder: (context, state) => DetailPage(movie: state.extra as Movie),
        ),
        GoRoute(
          path: '/time-booking',
          name: 'time-booking',
          builder: (context, state) =>
              TimeBookingPage(movieDetail: state.extra as MovieDetail),
        ),
        GoRoute(
          path: '/seat-booking',
          name: 'seat-booking',
          builder: (context, state) => SeatBookingPage(
            transactionDetail: state.extra as (MovieDetail, Transaction),
          ),
        ),
        GoRoute(
          path: '/booking-confirmation',
          name: 'booking-confirmation',
          builder: (context, state) => BookingConfirmationPage(
            state.extra as (MovieDetail, Transaction),
          ),
        ),
        GoRoute(
          path: '/wallet',
          name: 'wallet',
          builder: (context, state) => const WalletPage(),
        ),
        GoRoute(
          path: '/update-profile',
          name: 'update-profile',
          builder: (context, state) => const UpdateProfilePage(),
        ),
        GoRoute(
          path: '/change-password',
          name: 'change-password',
          builder: (context, state) => const ChangePasswordPage(),
        ),
      ],
      initialLocation: '/login',
      debugLogDiagnostics: false,
    );
