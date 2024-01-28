import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetWedChecklist extends StatelessWidget {
  final String id;

  GetWedChecklist({required this.id});

  @override
  Widget build(BuildContext context) {

    CollectionReference wed_check = FirebaseFirestore.instance.collection('wed_checklist');
    return FutureBuilder<DocumentSnapshot>(future: wed_check.doc(id).get(),builder: ((context,snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        print('apa ni' + data['title']);
        return Text(data['title']);
      }
      return Text('Loading ...');
    }));
  }
}
