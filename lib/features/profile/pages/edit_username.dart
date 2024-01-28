import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
import 'package:wed_app/features/profile/user/user_data.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditUsernameFormPage extends StatefulWidget {
  const EditUsernameFormPage({Key? key}) : super(key: key);

  @override
  EditUsernameFormPageState createState() {
    return EditUsernameFormPageState();
  }
}

class EditUsernameFormPageState extends State<EditUsernameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  var user = UserData.myUser;
  late String name = '';
  // late String username ='';
  late String email = '';

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  void loadData() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    setState(() {
      name = _sharedPreferences.getString('name') ?? '';
      usernameController.text =
          _sharedPreferences.getString('username') ?? user.username;
      email = _sharedPreferences.getString('email') ?? '';
      // phone = _sharedPreferences.getString('phone') ?? '';
      // image = _sharedPreferences.getString('image') ?? '';
      // about = _sharedPreferences.getString('about') ?? '';
    });
  }

  void updateUserValue(String username) async {
    user.username = username;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    DocumentReference<Map<String, dynamic>> userdata =
        querySnapshot.docs.first.reference;
    userdata.update({'username': username}).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              width: 320,
              child: Text(
                "What's Your Username?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SizedBox(
                height: 100,
                width: 320,
                child: TextFormField(
                  controller: usernameController,
                  // Handles Form Validation for First Name
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new username';
                    } else if (!isAlphanumeric(value)) {
                      return 'Only Letters and Number Please';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate() &&
                          isAlphanumeric(usernameController.text)) {
                        updateUserValue(usernameController.text);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 15),
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
}
