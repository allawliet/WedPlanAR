import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wed_app/features/profile/pages/edit_description.dart';
import 'package:wed_app/features/profile/pages/edit_email.dart';
import 'package:wed_app/features/profile/pages/edit_image.dart';
import 'package:wed_app/features/profile/pages/edit_name.dart';
import 'package:wed_app/features/profile/pages/edit_phone.dart';
import 'package:wed_app/features/profile/pages/edit_username.dart';
import 'package:wed_app/features/profile/user/user_data.dart';
import 'package:wed_app/features/profile/widgets/display_image_widget.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userData = FirebaseFirestore.instance.collection('users');

  late Map<String, Object> _currentUser = {};
  var user = UserData.myUser;
  late String name = '';
  late String username = '';
  late String email = '';
  late String phone = '';
  late String image = '';
  late String about = '';

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserByEmail(
      String email) async {
    try {
      // Reference to the 'users' collection
      CollectionReference<Map<String, dynamic>> users = userData;

      // Query for the document with the specified email
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await users.where('email', isEqualTo: email).get();

      // Check if there is a matching document
      if (querySnapshot.docs.isNotEmpty) {
        // Return the first document found
        return querySnapshot.docs.first;
      } else {
        // No matching document found
        return null;
      }
    } catch (e) {
      // Handle errors
      print('Error retrieving user data: $e');
      return null;
    }
  }

  Future getUserData() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    var data = await getUserByEmail(currentUser.email.toString());
    if (data != null && data.exists) {
      setState(() {
        _sharedPreferences.setString('username', data['username']);
        _sharedPreferences.setString('name', data['name']);
        _sharedPreferences.setString('phone', data['phone']);
        _sharedPreferences.setString('image', data['image']);
        _sharedPreferences.setString('email', data['email']);
        _sharedPreferences.setString('about', data['about']);
      });
    }
    loadData();
  }

  void loadData() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    setState(() {
      name = _sharedPreferences.getString('name') ?? '';
      username = _sharedPreferences.getString('username') ?? '';
      email = _sharedPreferences.getString('email') ?? '';
      phone = _sharedPreferences.getString('phone') ?? '';
      image = _sharedPreferences.getString('image') ?? 'assets/profile/profile.png';
      about = _sharedPreferences.getString('about') ?? '';
    });
  }

  @override
  void initState() {
    // loadData();
    getUserData();
    // UserData.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = UserData.getUser();
    // print(_currentUser);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body:
          // SingleChildScrollView(
          //   child: Container(
          //     padding: const EdgeInsets.all(12),
          //     alignment: Alignment.center,
          //     child:
          FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          return Column(
            children: [
              InkWell(
                  onTap: () {
                    navigateSecondPage(EditImagePage());
                  },
                  child: DisplayImage(
                    imagePath: image,
                    onPressed: () {},
                  )),
              buildUserInfoDisplay(
                  username, 'Username', EditUsernameFormPage()),
              buildUserInfoDisplay(name, 'Name', EditNameFormPage()),
              buildUserInfoDisplay(phone, 'Phone', EditPhoneFormPage()),
              buildUserInfoDisplay(email, 'Email', EditEmailFormPage()),
              Expanded(
                child: buildAbout(about),
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              width: 350,
              height: 40,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        navigateSecondPage(editPage);
                      },
                      child: Text(
                        getValue,
                        style: const TextStyle(fontSize: 16, height: 1.4),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 40.0,
                  )
                ],
              ),
            )
          ],
        ),
      );

  // Widget builds the About Me Section
  Widget buildAbout(String about) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 100,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          navigateSecondPage(EditDescriptionFormPage());
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  about,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ),
                            ),
                        ),
                    ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ],
              ),
          )
        ],
      ),
  );

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
