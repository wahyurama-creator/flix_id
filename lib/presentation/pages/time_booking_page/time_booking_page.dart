import 'package:flix_id/domain/entity/movie/movie_detail.dart';
import 'package:flix_id/domain/entity/transaction/transaction.dart';
import 'package:flix_id/presentation/extensions/extensions.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/back_app_bar/back_app_bar.dart';
import 'package:flix_id/presentation/widgets/buttons/primary_button.dart';
import 'package:flix_id/presentation/widgets/card/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'methods/options.dart';

class TimeBookingPage extends ConsumerStatefulWidget {
  final MovieDetail movieDetail;

  const TimeBookingPage({
    super.key,
    required this.movieDetail,
  });

  @override
  ConsumerState<TimeBookingPage> createState() => _TimeBookingPageState();
}

class _TimeBookingPageState extends ConsumerState<TimeBookingPage> {
  final List<String> theaters = [
    'XXI The Botanical',
    'XXI The Breeze',
    'XXI The Downtown',
    'CGV Paris van Java',
    'CGV Pascal Hyper Square',
  ];

  final List<DateTime> dates = List.generate(
    7,
    (index) {
      DateTime now = DateTime.now();
      DateTime date = DateTime(now.year, now.month, now.day);
      return date.add(Duration(days: index));
    },
  );

  final List<int> hours = List.generate(
    8,
    (index) => (index + 2) + 12,
  );

  String? _selectedTheater;
  DateTime? _selectedDate;
  int? _selectedHour;

  @override
  Widget build(BuildContext context) {
    var imageUrl =
        widget.movieDetail.backdropPath ?? widget.movieDetail.posterPath;

    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 0, 24),
                child: BackAppBar(
                  title: widget.movieDetail.title,
                  onTap: () {
                    ref.read(routerProvider).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: NetworkImageCard(
                  width: MediaQuery.of(context).size.width - 48,
                  height: (MediaQuery.of(context).size.width - 48) * 0.6,
                  borderRadius: 15,
                  imageUrl: '${dotenv.env['TMDB_IMG_BASE_URL']}$imageUrl',
                  fit: BoxFit.cover,
                ),
              ),
              ...options(
                title: 'Select Theater',
                options: theaters,
                selectedItem: _selectedTheater,
                itemToString: (theater) => theater,
                onTap: (theater) => setState(() {
                  _selectedTheater = theater;
                }),
              ),
              verticalSpace(24),
              ...options(
                title: 'Select Date',
                options: dates,
                selectedItem: _selectedDate,
                itemToString: (date) => DateFormat(
                  'EEE, d MMMM y',
                ).format(date),
                onTap: (date) => setState(() {
                  _selectedDate = date;
                }),
              ),
              verticalSpace(24),
              ...options(
                title: 'Select Hour',
                options: hours,
                selectedItem: _selectedHour,
                itemToString: (hour) => '$hour:00',
                isOptionEnabled: (hour) =>
                    _selectedDate != null &&
                    DateTime(
                      _selectedDate!.year,
                      _selectedDate!.month,
                      _selectedDate!.day,
                      hour,
                    ).isAfter(
                      DateTime.now(),
                    ),
                onTap: (hour) => setState(() {
                  _selectedHour = hour;
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 24,
                ),
                child: PrimaryButton(
                  title: 'Next',
                  backgroundColor: saffronColor,
                  textColor: backgroundColor,
                  onPressed: () {
                    if (_selectedDate == null ||
                        _selectedTheater == null ||
                        _selectedHour == null) {
                      context.showSnackBar('Please select all options');
                    } else {
                      var user = ref.read(userDataProvider).value!;

                      Transaction transaction = Transaction(
                        uid: user.uid,
                        title: widget.movieDetail.title,
                        adminFee: 2000,
                        total: 0,
                        watchingTime: DateTime(
                          _selectedDate!.year,
                          _selectedDate!.month,
                          _selectedDate!.day,
                          _selectedHour!,
                        ).millisecondsSinceEpoch,
                        transactionImage: widget.movieDetail.posterPath,
                        theaterName: _selectedTheater,
                      );

                      ref.read(routerProvider).pushNamed(
                        'seat-booking',
                        extra: (widget.movieDetail, transaction),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
