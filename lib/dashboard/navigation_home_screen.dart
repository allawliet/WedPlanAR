import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:wed_app/features/app_theme.dart';
import 'package:wed_app/custom_drawer/home_drawer.dart';
import 'package:wed_app/features/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:wed_app/features/profile/pages/profile_page.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({Key? key}) : super(key: key);

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: screenView,
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.Profile:
          setState(() {
            screenView = ProfilePage();
          });
          break;
        case DrawerIndex.HOME:
          setState(() {
            screenView = const MyHomePage();
          });
          break;
        // case DrawerIndex.Help:
        //   setState(() {
        //     screenView = HelpScreen();
        //   });
        //   break;
        // case DrawerIndex.FeedBack:
        //   setState(() {
        //     screenView = FeedbackScreen();
        //   });
        //   break;
        // case DrawerIndex.Invite:
        //   setState(() {
        //     screenView = InviteFriend();
        //   });
        //   break;
        default:
          break;
      }
    }
  }
}
