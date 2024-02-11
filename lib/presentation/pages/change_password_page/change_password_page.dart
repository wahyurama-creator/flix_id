import 'package:flix_id/presentation/extensions/extensions.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/back_app_bar/back_app_bar.dart';
import 'package:flix_id/presentation/widgets/buttons/primary_button.dart';
import 'package:flix_id/presentation/widgets/text_field/flix_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();

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
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                BackAppBar(
                  title: 'Change Password',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(40),
                FlixTextFormField(
                  labelText: 'New Password',
                  controller: _newPasswordController,
                  obscureText: true,
                ),
                verticalSpace(40),
                PrimaryButton(
                  title: 'Update Password',
                  onPressed: () {
                    if (_newPasswordController.text.isNotEmpty) {
                      ref.read(userDataProvider.notifier).changePassword(
                            newPassword: _newPasswordController.text,
                          );
                    }
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
