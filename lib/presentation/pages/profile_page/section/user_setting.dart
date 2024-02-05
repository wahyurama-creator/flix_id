import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/widgets/profile/profile_item.dart';
import 'package:flutter/material.dart';

Widget userSetting() => Column(
      children: [
        const Divider(),
        verticalSpace(8),
        profileItem('Update Profile'),
        profileItem('My Wallet'),
        profileItem('Change Password'),
        profileItem('Change Language'),
        verticalSpace(8),
        const Divider(),
        verticalSpace(8),
        profileItem('Contact Us'),
        profileItem('Privacy Policy'),
        profileItem('Terms & Conditions'),
        verticalSpace(8),
      ],
    );
