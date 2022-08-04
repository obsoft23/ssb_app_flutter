// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element, avoid_print, avoid_unnecessary_containers, unused_field, unnecessary_import, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/components/review_parse.dart';
import 'package:flutter_application_1/screens/models/user_model.dart';
import 'package:flutter_application_1/screens/models/message_modal.dart';
import 'package:flutter_application_1/screens/components/details.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:comment_box/comment/test.dart';
import 'package:comment_box/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/network/api.dart';

class ReviewPage extends StatefulWidget {
  final int id;

  const ReviewPage({Key? key, required this.id}) : super(key: key);
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

List reviews = [];
List filedata = [];
late String? userImageURL;
late String? userAccName;
var userRating;

class _ReviewPageState extends State<ReviewPage> {
  final _sendmessagecontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  /*List filedata = [
      {
      'name': 'Adeleye Ayodeji',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              reviews.clear();
              filedata.clear();
            },
            child: Container(
              margin: EdgeInsets.only(left: 8),
              child: Center(
                child: Icon(Icons.arrow_back_ios, color: Colors.blue, size: 16),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) => bottomSheetList(context));
              },
              icon: Icon(Icons.star),
              color: Colors.black54,
            )
          ],
          title: Text(
            "Reviews",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder(
            future: fetchReviews(widget.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  null != snapshot.data) {
                return buildReviewPage(context);
              } else if (null != snapshot.error) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget buildReviewPage(BuildContext context) {
    return Container(
      child: CommentBox(
        userImage: "http://localhost:8000/api/fetch-user-image/${userImageURL}",
        child: commentChild(),
        labelText: 'Write a review...',
        withBorder: false,
        errorText: 'Review cannot be blank',
        sendButtonMethod: () async {
          if (formKey.currentState!.validate() || userRating.isEmpty) {
            print(commentController.text);
            if (userRating != null) {
              final success = await Network()
                  .sendReview(widget.id, commentController.text, userRating);
              print(success);
              if (success == true) {
                commentController.clear();
                setState(() {
                  fetchReviews(widget.id);
                });
              } else {
                print("please rate");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Please select a rating..."),
                    duration: const Duration(seconds: 6),
                  ),
                );
              }
            }
          } else {
            print("Not validated");
          }
        },
        formKey: formKey,
        commentController: commentController,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        sendWidget: Icon(Icons.send_sharp, size: 24, color: Colors.white),
      ),
    );
  }

  Widget commentChild() {
    return reviews.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("No reviews made yet ...")),
          )
        : ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () async {
                      // Display the image in large form.
                      print("Comment Clicked$index");
                    },
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            "http://localhost:8000/api/fetch-user-image/${filedata[index]['image']}"),
                      ),
                    ),
                  ),
                  title: Text(
                    filedata[index]['name'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  subtitle: Text(reviews[index].review),
                ),
              );
            },
          );
  }
}

fetchReviews(int id) async {
  print("fetch business id${id}");
  filedata.clear();
  reviews.clear();

  final response = await http.get(
    Uri.parse("http://localhost:8000/api/business/fetch/review/${id}"),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  print(response.body);
  if (response.statusCode == 200) {
    final _reviews = jsonDecode(response.body);

    for (var review in _reviews["reviews"]) {
      reviews.add(Review.fromJson(review));
    }

    /*  for (var user in _reviews["user"]) {
      filedata.add(ReviewProfile.fromJson(user));
    }*/

    filedata = _reviews["user"];

    await Future.delayed(const Duration(seconds: 1));
    print(" comments got $reviews");
    final prefs = await SharedPreferences.getInstance();
    userAccName = prefs.getString("user_acc_name");
    userImageURL = prefs.getString("profile_image_url");

    return reviews;
  }
}

bottomSheetList(context) {
  return SizedBox(
    height: 160,
    child: Center(
      child: RatingBar.builder(
        initialRating: 0.1,
        minRating: 0.1,
        itemSize: 40,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          userRating = rating;
          print("new rating $userRating");
        },
      ),
    ),
  );
}
