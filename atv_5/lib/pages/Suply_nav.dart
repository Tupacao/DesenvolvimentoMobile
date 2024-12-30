import 'package:flutter/material.dart';

class SuplyNav extends StatefulWidget {
  
  final Function(double) saveValue;
  const SuplyNav({super.key, required this.saveValue});

  @override
  State<SuplyNav> createState() => _SuplyNavState();
}

class _SuplyNavState extends State<SuplyNav> {
  double _sliderValue = 01;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Quanto de RaçõesTupac você quer levar:",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 20),
          Slider(
            value: _sliderValue,
            min: 1,
            max: 20000, // Valor máximo
            label: _sliderValue.toStringAsFixed(0), // Rótulo do valor
            onChanged: (double newValue) {
              setState(() {
                _sliderValue = newValue; // Atualiza o valor do Slider
              });
            },
          ),
          const Text(
            "Valor em (Tupakirsons[kg]):",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _sliderValue.toStringAsFixed(0),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 250,
            height: 50,
            child: FilledButton(
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Deixa o botão quadrado
                  ),
                ),
                onPressed: () {
                  widget.saveValue(_sliderValue);
                },
                child: const Text(
                  "Salvar Suprimento",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
