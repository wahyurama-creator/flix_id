import 'package:flix_id/domain/entity/transaction/transaction.dart';
import 'package:flix_id/presentation/extensions/int_extensions.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: transaction.title != 'Top Up'
                      ? NetworkImage(
                          '${dotenv.env['TMDB_IMG_BASE_URL']}'
                          '${transaction.transactionImage}',
                        ) as ImageProvider
                      : const AssetImage('assets/topup.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEEE, d MMMM y').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        transaction.transactionTime!,
                      ),
                    ),
                    style: whiteTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: bold,
                      color: Colors.grey,
                    ),
                  ),
                  verticalSpace(6),
                  Text(
                    transaction.title,
                    style: whiteTextStyle.copyWith(
                      fontWeight: bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    transaction.title == 'Top Up'
                        ? '- ${(-transaction.total).toIDRCurrencyFormat()}'
                        : transaction.total.toIDRCurrencyFormat(),
                    style: whiteTextStyle.copyWith(
                      color: transaction.title == 'Top Up'
                          ? const Color.fromARGB(255, 107, 237, 90)
                          : const Color(0xFFEAA94E),
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
