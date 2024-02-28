import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

void postquote(name,quote,TextEditingController namecontroller,TextEditingController quotecontroller){
  if(name!='' && quote!=''){
    FirebaseFirestore.instance.collection("Quotes").add(
                                    
                                   {
                                    'name':name,
                                    'quote':quote,
                                    'likes':0,
                                    'ups':0,
                                   
                                    'delete':0,
                                    'replyname':'',
                                    'replyquote':'',
                                    'time':Timestamp.now()

                                   }


                                  );
                                  // namecontroller.clear();
                                  quotecontroller.clear();
  }
  
  
  
  

}
void postreply(name,quote,TextEditingController namecontroller,TextEditingController quotecontroller,replyname,replyquote){
  if(name!='' && quote!=''){
    FirebaseFirestore.instance.collection("Quotes").add(
                                    
                                   {
                                    'name':name,
                                    'quote':quote,
                                    'likes':0,
                                    'ups':0,
                                    
                                    'delete':0,
                                    'time':Timestamp.now(),
                                    'replyname':replyname,
                                    'replyquote':replyquote
                                   }


                                  );
                                  // namecontroller.clear();
                                  quotecontroller.clear();
  }
  
  
  
  

}


Stream<QuerySnapshot> getquotes(){
  final quotestream = FirebaseFirestore.instance.collection("Quotes").orderBy("time", descending: true).limit(10).snapshots();
  return quotestream;
}

Stream<QuerySnapshot> gettrendingquotes(){
  final quotestream = FirebaseFirestore.instance.collection("Quotes").limit(10).orderBy("ups", descending: true).snapshots();
  return quotestream;
}
