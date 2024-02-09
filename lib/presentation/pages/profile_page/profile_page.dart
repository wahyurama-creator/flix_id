import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/profile_page/section/user_info.dart';
import 'package:flix_id/presentation/pages/profile_page/section/user_setting.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/providers/utility/utility_provider.dart';
import 'package:flix_id/presentation/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var buildVersion = ref.read(getVersionNumber).value ?? '0.1.0';

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              ...userInfo(ref),
              userSetting(ref),
              verticalSpace(32),
              PrimaryButton(
                title: 'Logout',
                onPressed: () => ref.read(userDataProvider.notifier).logout(),
              ),
              verticalSpace(32),
              Text(
                'Version $buildVersion',
                style: whiteTextStyle.copyWith(fontSize: 10, fontWeight: light),
              ),
              verticalSpace(80),
            ],
          ),
        ),
      ],
    );
  }
}
