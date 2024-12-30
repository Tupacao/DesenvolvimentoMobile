import 'package:dm07/login.dart';
import 'package:dm07/multITENS.dart';
import 'package:flutter/material.dart';

void main (){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dm-Aula07",
      initialRoute: "/",
      routes: {
        "/" : (context) => const Login(),
        "/home": (context) => const Itens(),
      },
    )
  );
}