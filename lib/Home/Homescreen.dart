import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uphoric/Chatroom/Chatroom.dart';
import 'package:uphoric/Chatroom/Functionschat.dart';
import 'package:uphoric/Home/Trendingpage.dart';
import 'package:uphoric/Widgets/Icons.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var height,width;
  var colorbackround;
  var pagenum=0;
  bool reply=false;
  PageController pageController = PageController();
  @override
  
  
  

 
  void openwritebox(){
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
                            controller: namecontroller,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: quotecontroller,
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
                                  postquote(namecontroller.text, quotecontroller.text,namecontroller,quotecontroller);
                                  
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
  // void openreplywritebox(BuildContext context,replyname,replyquote){
  //    TextEditingController namecontroller2=TextEditingController();
  //    TextEditingController quotecontroller2=TextEditingController();
    
  //    showDialog(
  //               context: context,
  //               builder: (BuildContext context) {
  //                 return Dialog(
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10.0),
  //                   ),
  //                   child: Container(
  //                     padding: EdgeInsets.all(20.0),
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         TextField(
  //                           controller: namecontroller2,
  //                           decoration: InputDecoration(
  //                             hintText: 'Name',
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(5.0),
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(height: 10),
  //                         TextField(
  //                           controller: quotecontroller2,
  //                           decoration: InputDecoration(
  //                             hintText: 'Quote',
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(5.0),
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(height: 20),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           children: [
  //                             TextButton(
  //                               onPressed: () {
  //                                 Navigator.of(context).pop();
  //                               },
  //                               child: Text('Close'),
  //                             ),
  //                             SizedBox(width: 10),
  //                             ElevatedButton(
  //                               onPressed: () {
  //                                 postreply(namecontroller2.text, quotecontroller2.text, namecontroller2, quotecontroller2, replyname, replyquote);
                                  
  //                                 Navigator.of(context).pop();
  //                               },
  //                               child: Text('Post'),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               },
  //             );
            
  // }
 
  @override
  TextEditingController namecontroller=TextEditingController();
  TextEditingController quotecontroller=TextEditingController();

  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    colorbackround=Colors.deepPurple;
    return Scaffold(
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.deepPurple.shade300,
      child: Icon(Icons.add),
        onPressed: () {
          openwritebox();
        
      },),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor:colorbackround,
        height: 60.0,
        
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          picicon('assets/home.png'),
          picicon('assets/trending.png'),
         
     
        ],
        onTap: (index) {
          setState(() {
            
           pageController.jumpToPage(index);
          });
         
        
         
        },
      ),
      body: PageView(controller: pageController,
      onPageChanged: (value) {
        // pagenum=value;
      },
      physics: NeverScrollableScrollPhysics(),
        children: [Chatroom(height, width,context,colorbackround),trendingroom(height, width,context,colorbackround)]),
    );
  }
}
