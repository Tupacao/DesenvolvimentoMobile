import 'package:atv_6/Pages/Selections/Home.dart';
import 'package:atv_6/Pages/Selections/ListUsers.dart';
import 'package:atv_6/Pages/Selections/Profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Aplication extends StatefulWidget {
  const Aplication({super.key});

  @override
  State<Aplication> createState() => _AplicationState();
}

class _AplicationState extends State<Aplication> {
  int page = 0;
  List<String>? user;

  void getUserInfo () async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    user = pref.getStringList("user");
  }

  void isLogged () async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? logged = pref.getBool("islogged");
    if(logged == null || logged == false){
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    isLogged();
    getUserInfo();
    return Scaffold(
      body: IndexedStack(
        index: page,
        children: [
          Home(user: user,),
          const ListUsers(),
          Profile(user: user),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Conta',
          ),
        ],
        currentIndex: page,
        onTap: (value) {
          setState(() {
            page = value;
          });
        },
        selectedItemColor: Colors.blueAccent,
      ),
    );
  }
}
