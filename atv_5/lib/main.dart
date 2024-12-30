import 'package:flutter/material.dart';

import 'pages/Home_nav.dart';
import 'pages/Status_nav.dart';
import 'pages/Suply_nav.dart';
import 'pages/Tripulation_nav.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ControllerPage(),
  ));
}

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int _actualPage = 0;

  String? shipName;
  double? valueSuply;
  List<String> tripulants = [];

  void _addTripulant(String name) {
    setState(() {
      tripulants.add(name);
    });
  }

  void _removeTripulant(String name) {
    setState(() {
      tripulants.remove(name); // Remove o nome da lista
    });
  }

  void _saveShipName(String name) {
    setState(() {
      shipName = name;
    });
  }

  void _saveSuply(double value) {
    setState(() {
      valueSuply = value;
    });
  }

  void _updateIndex(int index) {
    setState(() {
      _actualPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Missão Espacial - Tupac11",
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.purple[700],
      ),
      body: IndexedStack(
        index: _actualPage,
        children: [
          HomeNav(onSave: _saveShipName),
          TripulationNav(
              onCheckboxChanged: _addTripulant,
              onRemoveTripulant: _removeTripulant),
          SuplyNav(saveValue: _saveSuply),
          StatusNav(
              shipName: shipName,
              valueSuply: valueSuply,
              tripulants: tripulants),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _actualPage,
          onTap: _updateIndex,
          fixedColor: Colors.yellow[700],
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.purple[700],
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.rocket_launch),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline_outlined),
              label: "Tripulação",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded),
              label: "Suprimentos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assessment),
              label: "Status",
            ),
          ]),
    );
  }
}
