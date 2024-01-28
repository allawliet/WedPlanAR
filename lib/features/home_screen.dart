import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:wed_app/features/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:wed_app/features/ar/ar_screen.dart';
import 'package:wed_app/features/profile/settings_screen.dart';
import 'package:wed_app/features/theme_list/theme_screen.dart';
import 'package:wed_app/features/wedding_checklist/wed_checklist_screen.dart';
import '../model/homelist.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  bool multiple = true;
  int _selectedIndex = 0;
  final double infoHeight = 364.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void scheduleNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Scheduled Notification',
        body: 'This notification was scheduled using AwesomeNotifications.',
      ),
      schedule: NotificationCalendar(
        minute: DateTime.now().minute + 1,
        second: 0,
        allowWhileIdle: true,
      ),
    );
  }

  void showBanner(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('This is a banner!'),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          // Perform some action when the "Dismiss" action is pressed
        },
      ),
    );
    // Find the Scaffold in the widget tree and show the SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // final double tempHeight = MediaQuery.of(context).size.height -
    //     (MediaQuery.of(context).size.width / 1.2) +
    //     24.0;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return <Widget>[
                            /// Home page
                            const Card(
                              shadowColor: Colors.transparent,
                              margin: EdgeInsets.all(8.0),
                              child: SizedBox.expand(
                                child: Center(
                                  child: Text(
                                    'Home page',
                                  ),
                                ),
                              ),
                            ),

                            /// Wedding Checklist page
                            const Card(
                              shadowColor: Colors.transparent,
                              margin: EdgeInsets.all(8.0),
                              child: SizedBox.expand(
                                child: Center(child: WeddingChecklistScreen()),
                              ),
                            ),

                            /// Deco page
                            const Card(
                              shadowColor: Colors.transparent,
                              margin: EdgeInsets.all(8.0),
                              child: Center(
                                child: ArScreen(),
                              ),
                            ),

                            /// Theme page
                            const Card(
                              shadowColor: Colors.transparent,
                              margin: EdgeInsets.all(8.0),
                              child: SizedBox.expand(
                                child: Center(child: ThemeScreen()),
                              ),
                            ),

                            /// Profile page
                            const Card(
                              shadowColor: Colors.transparent,
                              margin: EdgeInsets.all(8.0),
                              child: SizedBox.expand(
                                child: Center(child: SettingsPage()),
                              ),
                            ),
                          ][_selectedIndex];
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scheduleNotification();
        },
        child: const Icon(
            Icons.notification_add
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey,
        onTap: _changeIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist), label: "Checklist"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Deco"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Theme"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting")
        ],
      ),
    );
  }

  Widget appBar() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4, right: 50),
                child: Text(
                  'Wedding',
                  style: TextStyle(
                    fontSize: 22,
                    color: isLightMode ? AppTheme.darkText : AppTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key? key,
      this.listData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final HomeList? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                        listData!.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: callBack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
