import 'package:atv_6/Login/Register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void _isLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? logged = prefs.getBool("islogged");
    if (logged == true) {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  void _login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? user = prefs.getStringList("user");

    if (user != null) {
      if (user[1] == email.text && user[2] == password.text) {
        prefs.setBool("islogged", true);
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        _dialogCreator();
      }
    } else {
      _dialogCreator();
    }
  }

  void _dialogCreator() {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text("Erro ao realizar login"),
              content: Text("Email ou senha estão errados, tente novamente"),
            ));
  }

  @override
  Widget build(BuildContext context) {
    _isLogged();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "REALIZAR LOGIN",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              maxLength: 40,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: password,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              maxLength: 6,
            ),
            const SizedBox(height: 20),
            FilledButton(
                onPressed: () {
                  _login();
                },
                child: const Text("Login")),
            const SizedBox(height: 30),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Register()),
                  );
                },
                child: const Text("Ainda não tem uma conta? Crie uma aqui"))
          ],
        ),
      ),
    );
  }
}
