import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  final List<String>? user;
  const Home({super.key, required this.user});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/assets/Logo.png"),
            Text("Bem vindo de volta ${widget.user?[0]}. Obrigado por nos deixar te ajudar. Tupac INC agradeçe")
          ],
        ),
        )
    );
  }
}