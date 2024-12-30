import 'package:flutter/material.dart';

class HomeNav extends StatefulWidget {

  final Function(String) onSave; // Callback para salvar o nome

  const HomeNav({super.key, required this.onSave});

  @override
  State<HomeNav> createState() => _HomeNavState();

}

class _HomeNavState extends State<HomeNav> {
  @override
  Widget build(BuildContext context) {
    TextEditingController shipName = TextEditingController();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Nome da Nave",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: shipName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Exemplo: Tupac11",
              ),
              maxLength: 20,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Deixa o botão quadrado
                    ),
                  ),
                  onPressed: () {
                    widget.onSave(shipName.text);
                  },
                  child: const Text(
                    "Salvar Nome",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
