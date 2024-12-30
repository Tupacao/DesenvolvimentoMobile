import 'dart:ui';

import 'package:flutter/material.dart';

void main (){
  runApp( MaterialApp(
    title: "Algo",
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Inputs"),
        centerTitle: true,
      ),
      drawer: const Drawer(
        child: Center(
          child: Text("Otário que abriu")
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
          const TextField(
            decoration: InputDecoration(labelText: "Email"),
          ),
          const TextField(
            decoration: InputDecoration(labelText: "Senha"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: (){},
            child: const Text("Clica em mim"),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text("Novo?", textAlign: TextAlign.center),
              TextButton(onPressed: (){}, child: const Text("Cadastre agora"))
            ],
          )
        ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Pessoa"
          )
        ],

      ),
    ),
    debugShowCheckedModeBanner: false,
  ));
}