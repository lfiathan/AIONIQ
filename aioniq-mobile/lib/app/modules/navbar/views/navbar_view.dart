import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../controllers/navbar_controller.dart';
import '../widget/fab_menu_widget.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import '../../../constant/app_colors.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HawkFabMenuController hawkFabMenuController = HawkFabMenuController();

    return PersistentTabView(
      navBarBuilder: (navBarConfig) {
        return Style8BottomNavBar(navBarConfig: navBarConfig);
      },
      tabs: controller.tabs(),
      floatingActionButton: HawkFabMenu(
        heroTag: 'main_menu',
        blur: 3,
        icon: AnimatedIcons.add_event,
        fabColor: AppColors.normalBlue,
        iconColor: Colors.white,
        hawkFabMenuController: hawkFabMenuController,
        items: fabMenu(context),
        body: const SizedBox(),
      ),
    );
  }
}

