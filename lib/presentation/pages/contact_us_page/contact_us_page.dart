import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactUsPage extends ConsumerWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
        backgroundColor: backgroundColor,
        leading: GestureDetector(
          onTap: () => ref.read(routerProvider).pop(),
          child: const Icon(Icons.keyboard_arrow_left, size: 40),
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: (MediaQuery.of(context).size.height - 48) * 0.5,
          margin: const EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            color: Colors.grey.shade800.withOpacity(0.55),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset('assets/flix_logo.png', width: 150),
              ),
              verticalSpace(24),
              Text(
                'General Information',
                style: saffronTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: bold,
                ),
              ),
              verticalSpace(16),
              const Text('customer-care@flix.id'),
              verticalSpace(6),
              const Text('wahyurama@flix.id'),
              verticalSpace(24),
              Text(
                'Telephone',
                style: whiteTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              verticalSpace(6),
              const Text('+62-xxxx-xxxx-xxxx'),
            ],
          ),
        ),
      ),
    );
  }
}
