import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Poke(),
  ));
}

class Poke extends StatefulWidget {
  const Poke({super.key});

  @override
  State<Poke> createState() => _PokeState();
}

class _PokeState extends State<Poke> {
  List<String> pokemon = [];

  void _findPokemon(String name) async {
    name = name.toLowerCase();
    String url = "https://pokeapi.co/api/v2/pokemon/$name";
    List<String> info = [];
    try {
      final resposta = await http.get(Uri.parse(url));

      if (resposta.statusCode == 200) {
        var dados = json.decode(resposta.body);

        // Adiciona o nome do Pokémon
        info.add(dados['forms'][0]['name']);

        // Adiciona a URL da imagem
        info.add(dados['sprites']['other']['showdown']['front_default']);

        // Adiciona os tipos do Pokémon à lista
        for (var i = 0; i < dados['types'].length; i++) {
          info.add(dados['types'][i]['type']['name']);
        }

        print(info);

        // Atualiza o estado para refletir os novos dados na UI
        setState(() {
          pokemon = info;
        });
      } else {
        print("Erro na requisição: ${resposta.statusCode}");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Nome não encontrado'),
            content: const Text(
                'Por favor, insira o nome de um Pokémon válido para buscar.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print("Erro: $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: const Text(
              'Algo inesperado aconteceu, tente denovo'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Famosos Projeto de Pokemon",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset('assets/pokeball.png'),
          ),
          const SizedBox(height: 50),
          const Text(
            "Insira o nome do Pokemon",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: name,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Exemplo: Pikachu",
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 255, 17, 0), width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 255, 17, 0), width: 2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              if (name.text.isNotEmpty) {
                _findPokemon(name.text);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Campo de texto vazio'),
                    content: const Text(
                        'Por favor, insira o nome de um Pokémon para buscar.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                return const Color.fromARGB(255, 255, 17, 0);
              }),
              padding: WidgetStateProperty.resolveWith((states) {
                return const EdgeInsets.symmetric(vertical: 20, horizontal: 50);
              }),
              shape: WidgetStateProperty.resolveWith((states) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                );
              }),
              elevation: WidgetStateProperty.resolveWith((states) {
                return 5.0;
              }),
            ),
            child: const Text(
              "Buscar",
              style: TextStyle(
                color: Colors.white, // Cor do texto (branca)
                fontSize: 18, // Tamanho da fonte
                fontWeight: FontWeight.bold, // Texto em negrito
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (pokemon.isNotEmpty)
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 17, 0),
                border: Border.all(
                  color: Colors.black,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(200),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      pokemon[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Image.network(
                        pokemon[1],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var tipo in pokemon.sublist(2))
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "$tipo,",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
