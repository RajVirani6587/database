import 'package:database/view/firstScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(){
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>First_Screen(),
      },
    )
  );
}