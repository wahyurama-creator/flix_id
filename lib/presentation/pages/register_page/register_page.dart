import 'package:flix_id/presentation/extensions/extensions.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/buttons/primary_button.dart';
import 'package:flix_id/presentation/widgets/text_field/flix_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData && next.value != null) {
        ref.read(routerProvider).goNamed('main');
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    return Scaffold(
      body: ListView(
        children: [
          verticalSpace(50),
          Center(
            child: Image.asset('assets/flix_logo.png', width: 150),
          ),
          verticalSpace(50),
          const CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.add_a_photo_rounded,
              size: 50,
              color: Colors.white,
            ),
          ),
          verticalSpace(42),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                FlixTextFormField(
                  labelText: 'Name',
                  controller: _nameController,
                ),
                verticalSpace(16),
                FlixTextFormField(
                  labelText: 'Email',
                  controller: _emailController,
                  inputType: TextInputType.emailAddress,
                ),
                verticalSpace(16),
                FlixTextFormField(
                  labelText: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                ),
                verticalSpace(16),
                FlixTextFormField(
                  labelText: 'Confirm Password',
                  controller: _confirmPasswordController,
                  obscureText: true,
                ),
                verticalSpace(32),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? PrimaryButton(
                          title: 'Register',
                          onPressed: () {
                            if (_passwordController.text ==
                                _confirmPasswordController.text) {
                              ref.read(userDataProvider.notifier).register(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text,
                                    photoUrl: null,
                                  );
                            } else {
                              context.showSnackBar('Passwords is not match');
                            }
                          },
                        )
                      : const Center(child: CircularProgressIndicator()),
                  AsyncLoading() =>
                    const Center(child: CircularProgressIndicator()),
                  AsyncError(:final error) => Center(
                      child: Text(
                        error.toString(),
                        style: saffronTextStyle.copyWith(fontWeight: bold),
                      ),
                    ),
                  _ => const Center(child: CircularProgressIndicator()),
                },
                verticalSpace(42),
                GestureDetector(
                  onTap: () {
                    ref.read(routerProvider).goNamed('login');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: whiteTextStyle.copyWith(
                        fontWeight: light,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
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
