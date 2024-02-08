import 'package:flix_id/domain/entity/movie/movie_detail.dart';
import 'package:flix_id/domain/entity/transaction/transaction.dart';
import 'package:flix_id/domain/usecase/transaction/create_transaction/create_transaction.dart';
import 'package:flix_id/domain/usecase/transaction/create_transaction/create_transaction_params.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';
import 'package:flix_id/presentation/extensions/extensions.dart';
import 'package:flix_id/presentation/extensions/int_extensions.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/booking_confimation_page/methods/row_item_detail.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_id/presentation/providers/usecase/transaction/create_transaction/create_transaction_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/back_app_bar/back_app_bar.dart';
import 'package:flix_id/presentation/widgets/buttons/primary_button.dart';
import 'package:flix_id/presentation/widgets/card/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BookingConfirmationPage extends ConsumerWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const BookingConfirmationPage(this.transactionDetail, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (movieDetail, transaction) = transactionDetail;
    var widthItemRow = MediaQuery.of(context).size.width - 48;

    transaction = transaction.copyWith(
      total: transaction.ticketAmount! * transaction.ticketPrice! +
          transaction.adminFee,
    );

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                BackAppBar(
                  title: 'Booking Confirmation',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(24),
                NetworkImageCard(
                  width: MediaQuery.of(context).size.width - 48,
                  height: (MediaQuery.of(context).size.width - 48) * 0.6,
                  borderRadius: 15,
                  imageUrl: '${dotenv.env['TMDB_IMG_BASE_URL']}'
                      '${movieDetail.backdropPath ?? movieDetail.posterPath}',
                  fit: BoxFit.cover,
                ),
                verticalSpace(24),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: Text(
                    movieDetail.title,
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                verticalSpace(12),
                const Divider(),
                rowItemDetail(
                  title: 'Showing Date',
                  description: DateFormat('EEEE, d MMMM y').format(
                    DateTime.fromMillisecondsSinceEpoch(
                      transaction.watchingTime ?? 0,
                    ),
                  ),
                  width: widthItemRow,
                ),
                rowItemDetail(
                  title: 'Theater',
                  description: transaction.theaterName.toString(),
                  width: widthItemRow,
                ),
                rowItemDetail(
                  title: 'Seat Number',
                  description: transaction.seats!.join(', '),
                  width: widthItemRow,
                ),
                rowItemDetail(
                  title: 'Tickets',
                  description: '${transaction.ticketAmount} tickets',
                  width: widthItemRow,
                ),
                rowItemDetail(
                  title: 'Ticket Price',
                  description:
                      '${transaction.ticketPrice?.toIDRCurrencyFormat()}',
                  width: widthItemRow,
                ),
                rowItemDetail(
                  title: 'Adm. Fee',
                  description: transaction.adminFee.toIDRCurrencyFormat(),
                  width: widthItemRow,
                ),
                const Divider(),
                rowItemDetail(
                  title: 'Total',
                  description: transaction.total.toIDRCurrencyFormat(),
                  width: widthItemRow,
                ),
                verticalSpace(40),
                PrimaryButton(
                  title: 'Pay Now',
                  backgroundColor: saffronColor,
                  textColor: backgroundColor,
                  onPressed: () async {
                    int transactionTime = DateTime.now().millisecondsSinceEpoch;

                    transaction =
                        transaction.copyWith(transactionTime: transactionTime);

                    CreateTransaction createTransaction =
                        ref.read(createTransactionProvider);

                    await createTransaction(
                            CreateTransactionParams(transaction: transaction))
                        .then(
                      (result) {
                        switch (result) {
                          case ResultSuccess(value: _):
                            ref
                                .read(transactionDataProvider.notifier)
                                .refreshTransactionData();
                            ref
                                .read(userDataProvider.notifier)
                                .refreshUserData();

                            context.showSnackBar('Transaction Success');

                            ref.read(routerProvider).goNamed('main');

                          case ResultFailed(:final message):
                            context.showSnackBar(message);
                        }
                      },
                    );
                  },
                ),
                verticalSpace(40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
