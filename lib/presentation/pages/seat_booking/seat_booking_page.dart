import 'dart:math';

import 'package:flix_id/domain/entity/movie/movie_detail.dart';
import 'package:flix_id/domain/entity/transaction/transaction.dart';
import 'package:flix_id/presentation/extensions/extensions.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/seat_booking/methods/legend.dart';
import 'package:flix_id/presentation/pages/seat_booking/methods/movie_screen.dart';
import 'package:flix_id/presentation/pages/seat_booking/methods/seat_section.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/widgets/back_app_bar/back_app_bar.dart';
import 'package:flix_id/presentation/widgets/buttons/primary_button.dart';
import 'package:flix_id/presentation/widgets/seat/seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const SeatBookingPage({
    super.key,
    required this.transactionDetail,
  });

  @override
  ConsumerState<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends ConsumerState<SeatBookingPage> {
  List<int> selectedSeat = [];
  List<int> reservedSeat = [];

  @override
  void initState() {
    super.initState();

    Random random = Random();
    int reservedNumber = random.nextInt(36) + 1;

    while (reservedSeat.length < 8) {
      if (!reservedSeat.contains(reservedNumber)) {
        reservedSeat.add(reservedNumber);
      }
      reservedNumber = random.nextInt(36) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                BackAppBar(
                  title: movieDetail.title,
                  onTap: () {
                    ref.read(routerProvider).pop();
                  },
                ),
                movieScreen(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    seatSection(
                      seatNumbers: List.generate(18, (index) => index + 1),
                      onTap: _onSeatTap,
                      seatStatusChecker: _seatStatusChecker,
                    ),
                    horizontalSpace(30),
                    seatSection(
                      seatNumbers: List.generate(18, (index) => index + 19),
                      onTap: _onSeatTap,
                      seatStatusChecker: _seatStatusChecker,
                    ),
                  ],
                ),
                verticalSpace(24),
                legend(),
                verticalSpace(40),
                Text(
                  '${selectedSeat.length} seats selected',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                verticalSpace(40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: PrimaryButton(
                    title: 'Next',
                    onPressed: () {
                      if (selectedSeat.isNotEmpty) {
                        var updatedTransaction = transaction.copyWith(
                          seats:
                              (selectedSeat..sort()).map((e) => '$e').toList(),
                          ticketAmount: selectedSeat.length,
                          ticketPrice: 25000,
                        );

                        ref.read(routerProvider).pushNamed(
                          'booking-confirmation',
                          extra: (movieDetail, updatedTransaction),
                        );
                      } else {
                        context.showSnackBar('Please select at least one seat');
                      }
                    },
                  ),
                ),
                verticalSpace(40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSeatTap(number) {
    if (!selectedSeat.contains(number)) {
      setState(() {
        selectedSeat.add(number);
      });
    } else {
      setState(() {
        selectedSeat.remove(number);
      });
    }
  }

  SeatStatus _seatStatusChecker(number) => reservedSeat.contains(number)
      ? SeatStatus.reserved
      : selectedSeat.contains(number)
          ? SeatStatus.selected
          : SeatStatus.available;
}
