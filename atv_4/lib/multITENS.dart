import 'package:flutter/material.dart';

class Itens extends StatefulWidget {
  const Itens({super.key});

  @override
  State<Itens> createState() => _ItensState();
}

class _ItensState extends State<Itens> {
  List lista = [];

  void InsertIntoList() {
    for (var i = 0; i < 20; i++) {
      Map<String, dynamic> item = Map();
      item["title"] = "Titulo do Carinha aqui ${i + 1}";
      item["subtitle"] = "Sub do carinha logo ali ${i + 1}";
      lista.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? name = ModalRoute.of(context)?.settings.arguments as String;

    InsertIntoList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Bem Vindo $name"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, indice) {
                return ListTile(
                  onTap: () => {
                    // print("Deu um tap no carinha ${indice + 1}"),
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                title: Text(lista[indice]["title"]),
                                content: Text(lista[indice]["subtitle"]),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FilledButton(
                                        onPressed: () {
                                          print("Sim");
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Sim"),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      FilledButton(
                                        onPressed: () {
                                          print("Não");
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Não"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              // FilledButton(
                              //   onPressed: () {
                              //     print("Sim");
                              //     Navigator.pop(context);
                              //   },
                              //   child: const Text("Sim"),
                              // ),
                              // ElevatedButton(
                              //     onPressed: () {
                              //       print("KKKK");
                              //     },
                              //     child: Text("SIM")
                              // ),
                              // TextButton(onPressed: (){
                              //   print("Qual foi");
                              // }, child: Text("Oi"))
                            ],
                          );
                        }),
                  },
                  // onLongPress: () => {
                  //   print("deu uma prensada no ${indice + 1}")
                  // },
                  title: Text(lista[indice]["title"]),
                  subtitle: Text(lista[indice]["subtitle"]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
