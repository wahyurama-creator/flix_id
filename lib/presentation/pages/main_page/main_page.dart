import 'dart:io';

import 'package:flix_id/domain/entity/user/user.dart';
import 'package:flix_id/presentation/extensions/extensions.dart';
import 'package:flix_id/presentation/pages/movie_page/movie_page.dart';
import 'package:flix_id/presentation/pages/profile_page/profile_page.dart';
import 'package:flix_id/presentation/pages/ticket_page/ticket_page.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flix_id/presentation/widgets/bottom_nav_bar/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  final File? imageFile;

  const MainPage({super.key, this.imageFile});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    User? user = ref.read(userDataProvider).valueOrNull;
    if (widget.imageFile != null && user != null) {
      ref.read(userDataProvider.notifier).uploadProfilePicture(
            user: user,
            imageFile: widget.imageFile!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (previous != null && next is AsyncData && next.value == null) {
        ref.read(routerProvider).goNamed('login');
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (position) {
              setState(() {
                selectedIndex = position;
              });
            },
            children: [
              Center(
                child: MoviePage(),
              ),
              const Center(
                child: TicketPage(),
              ),
              const Center(
                child: ProfilePage(),
              ),
            ],
          ),
          BottomNavBar(
            items: [
              BottomNavBarItem(
                index: 0,
                isSelected: selectedIndex == 0,
                title: 'Home',
                icon: 'assets/movie.png',
                selectedIcon: 'assets/movie-selected.png',
              ),
              BottomNavBarItem(
                index: 1,
                isSelected: selectedIndex == 1,
                title: 'Ticket',
                icon: 'assets/ticket.png',
                selectedIcon: 'assets/ticket-selected.png',
              ),
              BottomNavBarItem(
                index: 2,
                isSelected: selectedIndex == 2,
                title: 'Profile',
                icon: 'assets/profile.png',
                selectedIcon: 'assets/profile-selected.png',
              ),
            ],
            onTap: (position) {
              selectedIndex = position;
              _pageController.animateToPage(selectedIndex,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            },
            selectedIndex: 0,
          )
        ],
      ),
    );
  }
}
