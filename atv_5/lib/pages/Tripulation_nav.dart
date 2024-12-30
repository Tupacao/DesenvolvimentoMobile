import 'package:flutter/material.dart';

class TripulationNav extends StatefulWidget {
  final Function(String name)? onCheckboxChanged; // Callback para o nome
  final Function(String name)? onRemoveTripulant; // Callback para o nome

  const TripulationNav({super.key, required this.onCheckboxChanged, required this.onRemoveTripulant});

  @override
  State<TripulationNav> createState() => _TripulationNavState();
}

class _TripulationNavState extends State<TripulationNav> {
  List<String> names = [
    "Tupac Nebulon",
    "Commander Tupac Starfire",
    "Tupac Orion",
    "Captain Tupac Nova",
    "Dr. Tupac Astrovoyager",
    "Tupac Celestial",
    "Admiral Tupac Cosmo",
    "Tupac Spacewalker",
    "Colonel Tupac Galaxy",
    "Tupac Interstellar",
  ];

  List<bool> checkedStates = List.filled(10, false);

  void _onCheckboxChanged(int index, bool? value) {
    // Verifica se o valor é verdadeiro e conta quantos já estão marcados
    if (value == true) {
      int checkedCount = checkedStates.where((isChecked) => isChecked).length;

      // Permite marcar apenas se menos de 5 estiverem marcados
      if (checkedCount < 5) {
        setState(() {
          checkedStates[index] = true; // Marca o Checkbox
        });
      }

      if (widget.onCheckboxChanged != null) {
          widget.onCheckboxChanged!(names[index]); // Retorna o nome
        }
    } else {
      setState(() {
        checkedStates[index] = false; // Desmarca o Checkbox
      });

      // Remove o tripulante da lista
        if (widget.onRemoveTripulant != null) {
          widget.onRemoveTripulant!(names[index]); // Remove o nome da lista de tripulantes
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded( // Eu acho que o Expanded não deixa eu centralizar usando a Column, mas eu não testei
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: names.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    names[index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Checkbox(
                      value: checkedStates[index],
                      onChanged: (value) {
                        _onCheckboxChanged(index, value);
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
