import 'package:atividades/AboutPage.dart';
import 'package:atividades/HomePage.dart';
import 'package:atividades/Login.dart';
import 'package:flutter/material.dart';

class GeralClasse extends StatefulWidget {
  const GeralClasse({super.key});

  @override
  State<GeralClasse> createState() => _GeralClasseState();
}

class _GeralClasseState extends State<GeralClasse> {
  int indice = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: indice,
        children: const [
          Login(),
          HomePage(),
          AboutPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Login"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.phone_bluetooth_speaker), label: "About"),
        ],
        onTap: (index) {
          setState((){
            indice = index;
          });
        },
      ),
    );
  }
}