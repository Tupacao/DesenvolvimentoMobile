import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final List<String>? user;
  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Seu Nome: ${widget.user?[0]}"),
            Text("Seu Email: ${widget.user?[1]}"),
            Text("Sua Senha: ${widget.user?[2]}"),
            FilledButton(
              onPressed: () async{
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("islogged");
                pref.remove("user");
                Navigator.pushReplacementNamed(context, "/");
              },
              child: const Text("Sair"),
            )
          ],
        ),),
    );
  }
}