// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({Key? key}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _addReviewScreenState();
}

class _addReviewScreenState extends State<AddReviewScreen> {
  final titleController = TextEditingController();
  final reviewController = TextEditingController();
  var ratings;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rate App",
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Give review',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
              Center(
                child: RatingBar.builder(
                    unratedColor: Colors.grey.shade900,
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    updateOnDrag: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                        ),
                    onRatingUpdate: (rating) {
                      ratings = rating;
                    }),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: TextField(
                  minLines: 1,
                  maxLines: 8,
                  style: const TextStyle(color: Colors.black),
                  controller: reviewController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Review (Optional)',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                      onPressed: () {
                        if (ratings == null) {
                          Fluttertoast.showToast(
                              msg: 'Please add a rating',
                              // backgroundColor: Colors.white,
                              textColor: Colors.black,
                              gravity: ToastGravity.BOTTOM);
                        }
                        // else if (titleController.text == '') {
                        //   Fluttertoast.showToast(
                        //       msg: 'Please add a Title to the review',
                        //       // backgroundColor: Colors.white,
                        //       textColor: Colors.black,
                        //       gravity: ToastGravity.BOTTOM);
                        // }
                        else {
                          // FirebaseFirestore.instance
                          //     .collection(collegeinfopage.college_id)
                          //     .doc(collegeinfopage.emailid)
                          //     .set({
                          //   "Email": collegeinfopage.emailid,
                          //   "Title": titleController.text,
                          //   "rating": ratings,
                          //   "Body": reviewController.text,
                          // });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Add review',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
