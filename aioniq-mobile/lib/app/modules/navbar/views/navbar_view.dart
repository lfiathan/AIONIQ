// lib/app/modules/navbar/views/navbar_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HawkFabMenuController hawkFabMenuController = HawkFabMenuController();

    return Scaffold(
      body: PersistentTabView(
        // --- PERBAIKAN: Gunakan controller yang sudah ada ---
        controller: controller.tabController,
        // ------------------------------------------------
        tabs: controller.tabs(),
        navBarBuilder: (NavBarConfig) =>
            Style13BottomNavBar(navBarConfig: NavBarConfig),
        floatingActionButton: HawkFabMenu(
          heroTag: 'main_menu',
          blur: 3,
          icon: AnimatedIcons.add_event,
          fabColor: const Color(0xff334893),
          iconColor: Colors.white,
          hawkFabMenuController: hawkFabMenuController,
          items: controller.fabMenu(context),
          body: const SizedBox(),
        ),
      ),
    );
  }
}
