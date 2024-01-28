// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:wed_app/features/pages/task_checklist.dart';
import 'package:wed_app/features/task_reminder/screens/home.dart';
import 'wed_checklist_app_theme.dart';

class WeddingChecklistScreen extends StatefulWidget {
  const WeddingChecklistScreen({Key? key});

  @override
  _WeddingChecklistScreenState createState() => _WeddingChecklistScreenState();
}

class _WeddingChecklistScreenState extends State<WeddingChecklistScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: WeddingChecklistAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.asset(
                    'assets/wedding/wedplan1.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.3) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: WeddingChecklistAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: WeddingChecklistAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(top: 30),
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            child: ListTile(
                              leading: const Text(
                                '10',
                                style:
                                    TextStyle(fontSize: 30, color: Colors.pink),
                              ),
                              title: const Text('Task Done'),
                              subtitle: const Text('View all checklist >'),
                              trailing: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 44,
                                  minHeight: 44,
                                  maxWidth: 64,
                                  maxHeight: 64,
                                ),
                                child: Image.asset('assets/images/speech.png',
                                    fit: BoxFit.cover),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskChecklistScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: const Text(
                                '5',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.orange),
                              ),
                              title: const Text('Task Reminder'),
                              subtitle: const Text('View all >'),
                              trailing: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 44,
                                  minHeight: 44,
                                  maxWidth: 64,
                                  maxHeight: 64,
                                ),
                                child: Image.asset(
                                    'assets/images/speech-girl.png',
                                    fit: BoxFit.cover),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Card(
                          //   child: ListTile(
                          //     leading: Icon(Icons.task_alt),
                          //     title: const Text('Saved Ideas'),
                          //     subtitle: const Text('View all >'),
                          //     trailing: ConstrainedBox(
                          //       constraints: const BoxConstraints(
                          //         minWidth: 44,
                          //         minHeight: 44,
                          //         maxWidth: 64,
                          //         maxHeight: 64,
                          //       ),
                          //       child: Image.asset('assets/images/team.png',
                          //           fit: BoxFit.cover),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: WeddingChecklistAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: WeddingChecklistAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: WeddingChecklistAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: WeddingChecklistAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
