import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool check() {
    return _emailController.text == "eumesmo@gmail.com" && _passwordController.text == "12345";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Seu Nome",
                    labelStyle: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  maxLength: 25,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  maxLength: 20,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      labelText: "Senha",
                      labelStyle: TextStyle(
                        fontSize: 1,
                      ),
                      suffixIcon: IconButton(
                          onPressed: null, icon: Icon(Icons.visibility))),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200, // Largura do botão
                  height: 50, // Altura do botão, tornando-o quadrado
                  child: FilledButton(
                    onPressed: () {
                      // print("teste");
                      bool logar = check();
                      if(logar){
                        setState(() {
                          Navigator.of(context).pushNamed(
                            "/home",
                            arguments: _nameController.text,
                            );
                        });
                      } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            title: Text("Não foi possível logar"),
                            content: Text("Senha ou email estão errados"),
                          );
                        });

                      }
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Faça Login Agora"),
                  ),
                )
              ],
            )));
  }
}
