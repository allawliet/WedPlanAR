import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wed_app/features/profile/user/user_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  var user = UserData.myUser;
  final imageController = TextEditingController();
  late String image = '';
  // late String username ='';
  late String email = '';
  late File _imageFile = File(user.image);

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    imageController.dispose();
    super.dispose();
  }

  void loadData() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    setState(() {
      imageController.text =
          _sharedPreferences.getString('image') ?? user.image;
      email = _sharedPreferences.getString('email') ?? '';
      _imageFile = File(imageController.text);
    });
  }

  void updateUserValue(String image) async {
    user.image = image;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    DocumentReference<Map<String, dynamic>> userdata =
        querySnapshot.docs.first.reference;
    userdata.update({'image': image}).then((value) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            width: 330,
            child: Text(
              "Upload a photo of yourself:",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 330,
              child: GestureDetector(
                onTap: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (image == null) return;
                  else {
                    setState(() {
                      _imageFile = File(image.path);
                    });
                  }

                  final location = await getApplicationDocumentsDirectory();
                  final name = basename(image.path);
                  final imageFile = File('${location.path}/$name');
                  final newImage = await File(image.path).copy(imageFile.path);
                  print(_imageFile);
                  setState(() {
                    user = user.copy(image: newImage.path);
                  });
                  updateUserValue(newImage.path);
                },
                child: Image.file(_imageFile),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 330,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
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
    );
  }
}
