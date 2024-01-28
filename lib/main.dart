// import 'dart:io';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:wed_app/database_service/sql_service.dart';
// import 'package:wed_app/features/app_theme.dart';
// import 'package:wed_app/login/login_screen.dart';
// import 'package:wed_app/main_page.dart';
// import 'package:wed_app/services/notification_controller.dart';
//
// bool shouldUseFirestoreEmulator = false;
//
// Future<void> main() async {
//   try {
//     await AwesomeNotifications().initialize(null, [
//       NotificationChannel(
//           channelGroupKey: "basic_channel_group",
//           channelKey: "basic_channel",
//           channelName: "Basic Notification",
//           channelDescription: "Test",
//           playSound: true,
//           importance: NotificationImportance.High,
//       ),
//     ], channelGroups: [
//       NotificationChannelGroup(
//           channelGroupKey: "basic_channel_group",
//           channelGroupName: "Basic Group")
//     ]);
//
//     bool isAllowedToSendNoti =
//         await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowedToSendNoti) {
//       AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//
//     WidgetsFlutterBinding.ensureInitialized();
//     Platform.isAndroid
//         ? await Firebase.initializeApp(
//             options: const FirebaseOptions(
//                 apiKey: 'AIzaSyBfbrPneUsaQOtXjKramOuM85Qdu_bIkgE',
//                 appId: '1:691731492482:android:deb803aedbd18ddf034e9b',
//                 messagingSenderId: '691731492482',
//                 projectId: 'wedding-planner-ar'))
//         : await Firebase.initializeApp();
//     FirebaseFirestore.instance.settings = const Settings(
//       persistenceEnabled: true,
//     );
//     if (shouldUseFirestoreEmulator) {
//       FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
//     }
//     await SqlServices.initDatabase();
//     await GetStorage.init();
//     await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown
//     ]).then((_) => runApp(const MyApp()));
//   } catch (errorMsg) {
//     print("Error:: " + errorMsg.toString());
//   }
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: NotificationController.onActionReceivedMethod,
//       onNotificationCreatedMethod:
//           NotificationController.onNotificationCreatedMethod,
//       onNotificationDisplayedMethod:
//           NotificationController.onNotificationDisplayedMethod,
//       onDismissActionReceivedMethod:
//           NotificationController.onDismissActionReceivedMethod,
//     );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//       statusBarBrightness:
//           !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
//       systemNavigationBarColor: Colors.white,
//       systemNavigationBarDividerColor: Colors.transparent,
//       systemNavigationBarIconBrightness: Brightness.dark,
//     ));
//     return GetMaterialApp(
//       title: 'Wedplan AR',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: AppTheme.textTheme,
//         platform: TargetPlatform.iOS,
//       ),
//       home: const MainPage(),
//     );
//   }
// }
//
// class HexColor extends Color {
//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
//
//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll('#', '');
//     if (hexColor.length == 6) {
//       hexColor = 'FF' + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

void main() {
  runApp(const MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: Center(
          child: OutlinedButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (cnt) => const UnityDemoScreen())),
              icon: const Icon(Icons.arrow_forward_rounded),
              label: const Text("Open Unity game"))),
    );
  }
}

class UnityDemoScreen extends StatefulWidget {
  const UnityDemoScreen({Key? key}) : super(key: key);

  @override
  _UnityDemoScreenState createState() => _UnityDemoScreenState();
}

class _UnityDemoScreenState extends State<UnityDemoScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
  GlobalKey<ScaffoldState>();
  late UnityWidgetController _unityWidgetController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Card(
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              UnityWidget(
                onUnityCreated: onUnityCreated,
                onUnityMessage: onUnityMessage,
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        OutlinedButton.icon(
                            onPressed: () => changeCurrentLevel("Level1"),
                            icon: const Icon(Icons.arrow_back_rounded),
                            label: const Text("Level 1")),
                        OutlinedButton.icon(
                            onPressed: () => changeCurrentLevel("Level2"),
                            icon: const Icon(Icons.arrow_forward_rounded),
                            label: const Text("Level 2")),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  changeCurrentLevel(String value) {
    _unityWidgetController.postMessage(
      'LevelController',
      'ChangeCurrentLevel',
      value,
    );
  }
}