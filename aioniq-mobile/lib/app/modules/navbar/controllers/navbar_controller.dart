import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../../routes/app_pages.dart';

class NavbarController extends GetxController {
  List<PersistentTabConfig> tabs() => [
    PersistentTabConfig(
      screen: GetRouterOutlet(initialRoute: Routes.HOME),
      item: ItemConfig(
        icon: const Icon(Icons.home),
        title: "Beranda",
        activeForegroundColor: CupertinoColors.white,
        activeColorSecondary: const Color(0xff334893),
        inactiveForegroundColor: CupertinoColors.systemGrey,
        inactiveBackgroundColor: CupertinoColors.white,
      ),
      navigatorConfig: NavigatorConfig(
        initialRoute: Routes.HOME,
        routes: {
          Routes.HOME: (context) => GetRouterOutlet(
            initialRoute: Routes.HOME,
          ),
        },
      ),
    ),
    PersistentTabConfig(
      screen: GetRouterOutlet(
        initialRoute: Routes.SCHEDULE,
      ),
      item: ItemConfig(
        icon: const Icon(Icons.alarm),
        title: "Jadwal",
        activeForegroundColor: CupertinoColors.white,
        activeColorSecondary: const Color(0xff334893),
        inactiveForegroundColor: CupertinoColors.systemGrey,
        inactiveBackgroundColor: CupertinoColors.white,
      ),
      navigatorConfig: NavigatorConfig(
        initialRoute: Routes.SCHEDULE,
        routes: {
          Routes.SCHEDULE: (context) => GetRouterOutlet(
            initialRoute: Routes.SCHEDULE,
          ),
        },
      ),
    ),
    PersistentTabConfig(
      screen: GetRouterOutlet(
        initialRoute: Routes.FAQ,
      ),
      item: ItemConfig(
        icon: const Icon(Icons.question_answer),
        title: "FAQ",
        activeForegroundColor: CupertinoColors.white,
        activeColorSecondary: const Color(0xff334893),
        inactiveForegroundColor: CupertinoColors.systemGrey,
        inactiveBackgroundColor: CupertinoColors.white,
      ),
      navigatorConfig: NavigatorConfig(
        initialRoute: Routes.FAQ,
        routes: {
          Routes.FAQ: (context) => GetRouterOutlet(
            initialRoute: Routes.FAQ,
          ),
        },
      ),
    ),
  ];
}
