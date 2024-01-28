import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
import 'package:wed_app/features/profile/user/user_data.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  var user = UserData.myUser;
  late String name = '';
  // late String username ='';
  late String email = '';
  final RegExp _inputValidator = RegExp(r'^[a-zA-Z0-9 ]+$');

  bool _validateInput(String input) {
    if (input == null || input.isEmpty) {
      return false;
    }

    if (!_inputValidator.hasMatch(input)) {
      return false;
    }

    return true;
  }

  void updateUserNameValue(String name) async {
    user.name = name;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    DocumentReference<Map<String, dynamic>> userdata =
        querySnapshot.docs.first.reference;
    print('apa2'+ userdata.toString());
    try {
      userdata.update({'name': name}).then((value) {
        Navigator.pop(context);
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  void loadData() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    setState(() {
      nameController.text = _sharedPreferences.getString('name') ?? user.name;
      email = _sharedPreferences.getString('email') ?? '';
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
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
                "What's Your Name?",
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
                  controller: nameController,
                  // Handles Form Validation for First Name
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    } else if (!_validateInput(value)) {
                      return 'Only letters and numbers please';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Name'),
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
                      print('apa'+ _validateInput(nameController.text).toString());
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate() &&
                          _validateInput(nameController.text)) {
                        updateUserNameValue(nameController.text);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
