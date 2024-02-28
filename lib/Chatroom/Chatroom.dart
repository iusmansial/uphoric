import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uphoric/Chatroom/Functionschat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> fetchReplyDetails(String replyId) async {
  try {
    DocumentSnapshot replySnapshot = await FirebaseFirestore.instance
        .collection('Quotes')
        .doc(replyId)
        .get();
    if (replySnapshot.exists) {
      String name = replySnapshot.get('name');
      String quote = replySnapshot.get('quote');
      print('Name: $name');
      print('Quote: $quote');
    } else {
      print('Document does not exist');
    }
  } catch (error) {
    print('Error fetching reply details: $error');
  }
}

// Example usage:
// Call the function and pass the reply document ID

Widget Chatroom(height, width, BuildContext context, colorbackround) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      height: height,
      width: width,
      color: colorbackround,
      child: StreamBuilder<QuerySnapshot>(
        stream: getquotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List quotelist = snapshot.data!.docs;
            return ListView.builder(
                itemCount: quotelist.length,
                itemBuilder: (context, index) {
                  //getting individual doc
                  DocumentSnapshot document = quotelist[index];
                  String docid = document.id;
                  // getting indvidual quotes
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String name = data['name'];
                  String quotemessage = data['quote'];
                  int likes = data['likes'];
                  int ups = data['ups'];

                  int delete = data['delete'];
                  String replyname = data['replyname'];
                  String replyquote = data['replyquote'];
                  //display quote
                  if (replyname == '' && replyquote == '') {
                    return quote(width, name, quotemessage, likes, ups, delete,
                        context, docid);
                  } else {
                    return reply(width, name, quotemessage, replyname,
                        replyquote, likes, ups, delete, context, docid);
                  }
                });
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Text("Error");
          }
        },
      ));
}

Widget quote(width, name, quotemessage, likes, ups, delete,
    BuildContext context, docid) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      width: width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(quotemessage),
          Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                  onTap: () {
                    delete++;
                    if (delete >= 20) {
                      FirebaseFirestore.instance
                          .collection('Quotes')
                          .doc(docid)
                          .delete();
                    }
                  },
                  child: Text("-$name"))),
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('Quotes')
                            .doc(docid)
                            .update({"likes": likes + 1});
                      },
                      icon: Icon(CupertinoIcons.heart)),
                  Text('$likes')
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('Quotes')
                            .doc(docid)
                            .update({"ups": ups + 1});
                      },
                      icon: Icon(CupertinoIcons.up_arrow)),
                  Text('$ups')
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        openreplywritebox(context, name, quotemessage);
                      },
                      icon: Icon(CupertinoIcons.reply)),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget reply(
  width,
  name,
  quotemessage,
  repliedname,
  repliedquote,
  likes,
  ups,
  delete,
  BuildContext context,
  docid,
) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: width,
                color: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                // margin: EdgeInsets.symmetric(vertical: 5),

                // color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$repliedquote',
                          style: TextStyle(color: Colors.white)),
                      Align(
                        child: Text(
                          '-$repliedname',
                          style: TextStyle(color: Colors.white),
                        ),
                        alignment: Alignment.bottomRight,
                      )
                    ])),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              // margin: EdgeInsets.symmetric(vertical: 5),
              width: width,

              // color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(quotemessage),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                          onTap: () {
                            delete++;
                            if (delete >= 20) {
                              FirebaseFirestore.instance
                                  .collection('Quotes')
                                  .doc(docid)
                                  .delete();
                            }
                          },
                          child: Text("-$name"))),
                  Row(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('Quotes')
                                    .doc(docid)
                                    .update({"likes": likes + 1});
                              },
                              icon: Icon(CupertinoIcons.heart)),
                          Text('$likes')
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('Quotes')
                                    .doc(docid)
                                    .update({"ups": ups + 1});
                              },
                              icon: Icon(CupertinoIcons.up_arrow)),
                          Text('$ups')
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                openreplywritebox(context, name, quotemessage);
                              },
                              icon: Icon(CupertinoIcons.reply)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void openreplywritebox(BuildContext context, name, quotemessage) {
  TextEditingController namecontroller2 = TextEditingController();
  TextEditingController quotecontroller2 = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namecontroller2,
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: quotecontroller2,
                decoration: InputDecoration(
                  hintText: 'Quote',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      postreply(
                          namecontroller2.text,
                          quotecontroller2.text,
                          namecontroller2,
                          quotecontroller2,
                          name,
                          quotemessage);

                      Navigator.of(context).pop();
                    },
                    child: Text('Post'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
