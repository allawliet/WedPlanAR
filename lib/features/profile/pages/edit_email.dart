import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wed_app/features/profile/user/user_data.dart';
import 'package:email_validator/email_validator.dart';

// This class handles the Page to edit the Email Section of the User Profile.
class EditEmailFormPage extends StatefulWidget {
  const EditEmailFormPage({Key? key}) : super(key: key);

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  User users = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  var user = UserData.myUser;
  late String email = '';

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void loadData() async {
    final SharedPreferences _sharedPreferences =
    await SharedPreferences.getInstance();

    setState(() {
      emailController.text =
          _sharedPreferences.getString('email') ?? user.email;
    });
  }

  void updateUserValue(String email) async {
    user.email = email;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    DocumentReference<Map<String, dynamic>> userdata =
        querySnapshot.docs.first.reference;

    userdata.update({'email': email}).then((value) {
      FirebaseAuth.instance.signOut();
    });
  }

  void updateEmail(String newEmail) async {
    try {
      if (user != null) {
        await users.updateEmail(newEmail).then((value) {
          // updateUserValue(newEmail);
        });
        print('Email updated successfully to: $newEmail');
      } else {
        print('User not signed in.');
      }
    } catch (e) {
      print('Error updating email: $e');
    }
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
                      "What's your email?",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Your email address'),

                        ),
                    ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 320,
                          height: 50,
                          // child:
                          // ElevatedButton(
                          //   onPressed: () {
                          //     // Validate returns true if the form is valid, or false otherwise.
                          //     if (_formKey.currentState!.validate() &&
                          //         EmailValidator.validate(
                          //             emailController.text)) {
                          //       updateEmail(emailController.text);
                          //       updateUserValue(emailController.text);
                          //     }
                          //   },
                          //   child: const Text(
                          //     'Update',
                          //     style: TextStyle(fontSize: 15),
                          //   ),
                          // ),
                        ),
                    ),
                )
              ],
          ),
        ),
    );
  }
}
