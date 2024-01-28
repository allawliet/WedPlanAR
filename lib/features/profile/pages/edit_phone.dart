import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
import 'package:wed_app/features/profile/user/user_data.dart';

// This class handles the Page to edit the Phone Section of the User Profile.
class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({Key? key}) : super(key: key);
  @override
  EditPhoneFormPageState createState() {
    return EditPhoneFormPageState();
  }
}

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  var user = UserData.myUser;
  late String phone = '';
  late String email = '';

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void loadData() async {
    final SharedPreferences _sharedPreferences =
    await SharedPreferences.getInstance();

    setState(() {
      phoneController.text =
          _sharedPreferences.getString('phone') ?? user.phone;
      email = _sharedPreferences.getString('email') ?? '';
    });
  }

  void updateUserValue(String phone) async {
    String formattedPhoneNumber = "(" +
        phone.substring(0, 3) +
        ") " +
        phone.substring(3, 6) +
        "-" +
        phone.substring(6, phone.length);
    user.phone = formattedPhoneNumber;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    DocumentReference<Map<String, dynamic>> userdata =
        querySnapshot.docs.first.reference;
    userdata.update({'phone': formattedPhoneNumber}).then((value) {
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
                      "What's Your Phone Number?",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (isAlpha(value)) {
                              return 'Only Numbers Please';
                            } else if (value.length < 10) {
                              return 'Please enter a VALID phone number';
                            }
                            return null;
                          },
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Your Phone Number',
                            hintText: '60123456789',
                            hintStyle: TextStyle(color: Colors.grey)
                          ),

                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 320,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate() &&
                                  isNumeric(phoneController.text)) {
                                updateUserValue(phoneController.text);
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}
