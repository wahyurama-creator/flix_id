import 'package:firebase_core/firebase_core.dart';
import 'package:flix_id/firebase_options.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  // Load .env file
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: saffronColor,
          background: backgroundColor,
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.poppins(
            color: ghostWhiteColor,
          ),
          bodyLarge: GoogleFonts.poppins(
            color: ghostWhiteColor,
          ),
          labelLarge: GoogleFonts.poppins(
            color: ghostWhiteColor,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: ref.watch(routerProvider).routeInformationParser,
      routeInformationProvider:
          ref.watch(routerProvider).routeInformationProvider,
      routerDelegate: ref.watch(routerProvider).routerDelegate,
    );
  }
}
