import 'package:atividades/Cadastro.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Página de Cadastro",
          style: TextStyle(
            fontSize: (25),
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const Drawer(
        child: Center(
          child: Text(
            "Por enquanto nada",
            style: TextStyle(
              fontSize: (18),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(40),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    maxLength: 20,
                  ),
                  const TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(
                          fontSize: 1,
                        ),
                        suffixIcon: IconButton(
                            onPressed: null, icon: Icon(Icons.visibility))),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: const Text(
                        "Salvar",
                        style: TextStyle(
                          fontSize: (18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Novo?", textAlign: TextAlign.center),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const Cadastro())
                            );
                          }, child: const Text("Cadastre agora"))
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
