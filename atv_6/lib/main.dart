import 'package:atv_6/Login/Login.dart';
import 'package:atv_6/Pages/Aplication.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "TupacaoCOP",
    routes: {
      '/': (context) => const Login(),
      '/home': (context) => const Aplication(),
    },
  ));
}