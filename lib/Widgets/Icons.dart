import 'package:flutter/material.dart';

Widget picicon(asset,{color=Colors.black}){
  return SizedBox(height: 30,
    child: Image(image: AssetImage(asset),color: color,));

}