import 'package:flutter/material.dart';
import 'package:wed_app/features/app_theme.dart';
import 'package:wed_app/custom_drawer/drawer_user_controller.dart';
import 'package:wed_app/custom_drawer/home_drawer.dart';
import 'package:wed_app/login/login_screen.dart';
// import 'package:wed_app/navigation_home_screen.dart';

class OnboardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnboardScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;
  

  @override
  void initState() {
    screenView = const LoginScreen();
    drawerIndex = DrawerIndex.HOME;
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
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            // screenView = const MyHomePage();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            // screenView = HelpScreen();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            // screenView = FeedbackScreen();
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
            // screenView = InviteFriend();
          });
          break;
        default:
          break;
      }
    }
  }
}