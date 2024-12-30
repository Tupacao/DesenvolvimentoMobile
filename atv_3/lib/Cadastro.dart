import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  late bool email = false, senha = false;
  String? secsu = "";
  double slide = 0;
  MaskedTextController layoutData = MaskedTextController(mask: '00/00/0000');
  MaskedTextController phone = MaskedTextController(mask: '(00) 0000000-00');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "Página de Cadastro",
          style: TextStyle(
            fontSize: (25 + slide),
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(
                  fontSize: 18 + slide,
                ),
              ),
              maxLength: 20,
            ),
            TextField(
              controller: layoutData,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: "Data de Nascimento",
                labelStyle: TextStyle(
                  fontSize: 18 + slide,
                ),
              ),
              maxLength: 10,
            ),
            TextField(
              controller: phone,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Número de Telefone",
                labelStyle: TextStyle(
                  fontSize: 18 + slide,
                ),
              ),
              maxLength: 15,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  fontSize: 18 + slide,
                ),
              ),
              maxLength: 20,
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    fontSize: 18 + slide,
                  ),
                  suffixIcon: const IconButton(
                      onPressed: null, icon: Icon(Icons.visibility))),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Gênero: ",
                  style: TextStyle(
                    fontSize: (16 + slide),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  "Maculino",
                  style: TextStyle(
                    fontSize: (14 + slide),
                  ),
                ),
                Radio(
                    value: "m",
                    groupValue: secsu,
                    onChanged: (String? str) {
                      setState(() {
                        secsu = str;
                      });
                    }),
                Text(
                  "Feminino",
                  style: TextStyle(
                    fontSize: (14 + slide),
                  ),
                ),
                Radio(
                    value: "f",
                    groupValue: secsu,
                    onChanged: (String? str) {
                      setState(() {
                        secsu = str;
                      });
                    }),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Notificações: ",
                  style: TextStyle(
                    fontSize: (20 + slide),
                  ),
                ),
                SwitchListTile(
                    title: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: (18 + slide),
                      ),
                    ),
                    value: email,
                    onChanged: (bool val) {
                      setState(() {
                        email = val;
                      });
                    }),
                SwitchListTile(
                    title: Text(
                      "Celular",
                      style: TextStyle(
                        fontSize: (18 + slide),
                      ),
                    ),
                    value: senha,
                    onChanged: (bool val) {
                      setState(() {
                        senha = val;
                      });
                    }),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: FloatingActionButton(
                onPressed: () {},
                child: Text(
                  "Salvar",
                  style: TextStyle(
                    fontSize: (18 + slide),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Slider(
              value: slide,
              min: 0,
              max: 10,
              label: "Tamanho da fonte",
              onChanged: (double value) {
                setState(() {
                  slide = value;
                });
              },
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Pessoa")
        ],
      ),
    );
  }
}
