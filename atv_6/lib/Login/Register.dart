import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  void _dialog( String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Erro ao realizar registro"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _register() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty) {
      if (password.text == confirmPassword.text) {
        List<String> user = [name.text, email.text, password.text];
        prefs.setStringList("user", user);

        name.clear();
        email.clear();
        password.clear();
        confirmPassword.clear();

        Navigator.pop(context);
      } else {
        _dialog("Senhas não batem");
      }
    } else {
      _dialog("Preencha todos os campos");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("CRIE SUA CONTA"),
            TextField(
              controller: name,
              keyboardType: TextInputType.text,
              maxLength: 40,
            ),
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              maxLength: 40,
            ),
            TextField(
              controller: password,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              maxLength: 6,
            ),
            TextField(
              controller: confirmPassword,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              maxLength: 6,
            ),
            FilledButton(
              onPressed: () {_register();},
              child: const Text("Criar conta"),
            ),
          ],
        ),
      ),
    );
  }
}
