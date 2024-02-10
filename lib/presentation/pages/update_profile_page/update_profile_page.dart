import 'dart:io';

import 'package:flix_id/domain/entity/user/user.dart';
import 'package:flix_id/presentation/extensions/extensions.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/back_app_bar/back_app_bar.dart';
import 'package:flix_id/presentation/widgets/buttons/primary_button.dart';
import 'package:flix_id/presentation/widgets/text_field/flix_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfilePage extends ConsumerStatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  ConsumerState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends ConsumerState<UpdateProfilePage> {
  XFile? xFile;

  @override
  Widget build(BuildContext context) {
    User? user = ref.watch(userDataProvider).valueOrNull;

    final TextEditingController nameController =
        TextEditingController(text: user?.name ?? '');

    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData && next.value != null) {
        ref.read(routerProvider).goNamed(
              'main',
              extra: xFile != null ? File(xFile!.path) : null,
            );
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
                  title: 'Update Profile',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(40),
                GestureDetector(
                  onTap: () async {
                    xFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: user?.photoUrl != null
                        ? NetworkImage(user!.photoUrl!)
                        : xFile != null || user?.photoUrl == null
                            ? FileImage(
                                File(xFile!.path),
                              )
                            : Image.asset('assets/pp-placeholder.png').image,
                    child: xFile != null && user?.photoUrl != null
                        ? null
                        : const Icon(
                            Icons.add_a_photo_rounded,
                            size: 50,
                            color: Colors.white,
                          ),
                  ),
                ),
                verticalSpace(40),
                FlixTextFormField(
                  labelText: 'Name',
                  controller: nameController,
                ),
                verticalSpace(40),
                switch (ref.watch(userDataProvider)) {
                  AsyncData() => PrimaryButton(
                    title: 'Update',
                    onPressed: () {
                      if (user != null) {
                        ref
                            .read(userDataProvider.notifier)
                            .updateUserProfile(
                          user: user,
                          name: nameController.text.toString(),
                        );
                      }
                    },
                  ),
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
                verticalSpace(40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
