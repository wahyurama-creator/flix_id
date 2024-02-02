import 'package:flix_id/presentation/extensions/extensions.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/buttons/primary_button.dart';
import 'package:flix_id/presentation/widgets/text_field/flix_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (previous, next) {
      // Check if the user is logged in go to main page
      if (next is AsyncData) {
        if (next.value != null) {
          ref.read(routerProvider).go('/main');
        }
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    return Scaffold(
      body: ListView(
        children: [
          verticalSpace(100),
          Center(
            child: Image.asset('assets/flix_logo.png', width: 150),
          ),
          verticalSpace(100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                FlixTextFormField(
                  labelText: 'Email',
                  controller: _emailController,
                ),
                verticalSpace(24),
                FlixTextFormField(
                  labelText: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                ),
                verticalSpace(12),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot Password?',
                      style: saffronTextStyle.copyWith(fontWeight: bold),
                    ),
                  ),
                ),
                verticalSpace(32),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? PrimaryButton(
                          title: 'Login',
                          onPressed: () {
                            ref.read(userDataProvider.notifier).login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                },
                verticalSpace(180),
                GestureDetector(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: whiteTextStyle.copyWith(
                        fontWeight: light,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: 'Register',
                          style: saffronTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
