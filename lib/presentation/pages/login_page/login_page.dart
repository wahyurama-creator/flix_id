import 'package:flix_id/domain/usecase/auth/login/login.dart';
import 'package:flix_id/domain/usecase/auth/login/login_params.dart';
import 'package:flix_id/presentation/pages/main_page/main_page.dart';
import 'package:flix_id/presentation/providers/usecase/auth/login/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Login'),
          onPressed: () {
            Login login = ref.watch(loginProvider);

            login(
              const LoginParams(
                email: 'deaultuser@gmail.com',
                password: '123123',
              ),
            ).then(
              (result) {
                if (result.isSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(
                        user: result.resultValue!,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${result.errorMessage}'),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
