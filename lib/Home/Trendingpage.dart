import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uphoric/Chatroom/Chatroom.dart';
import 'package:uphoric/Chatroom/Functionschat.dart';

Widget trendingroom(height,width,BuildContext context,colorbackround,){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
    height: height,
    width: width,
    color: colorbackround,
    child: StreamBuilder<QuerySnapshot>(
      stream: gettrendingquotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData){
          List quotelist= snapshot.data!.docs;
          return ListView.builder(
            itemCount: quotelist.length,
            itemBuilder: (context, index) {
              //getting individual doc
            DocumentSnapshot document = quotelist[index];
            String docid =document.id;
              // getting indvidual quotes
              Map<String,dynamic> data =document.data() as Map<String,dynamic>;
                String name=data['name'];
              String quotemessage=data['quote'];
              int likes=data['likes'];
              int ups=data['ups'];
              
              int delete =data['delete'];
              String replyname =data['replyname'];
              String replyquote =data['replyquote'];
              //display quote
             if(replyname==''&&replyquote==''){
                return quote(width, name, quotemessage,likes,ups,delete,context,docid);
             }
             else{
              return reply(width, name, quotemessage, replyname, replyquote, likes, ups,delete, context, docid);
             }
          


          }
          
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
            
            return Center(child: CircularProgressIndicator());
          }
          else{
            return Text("Error");
          }
      
      },


    )
  );
}