import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModificadorTexto extends StatelessWidget {
  //Variáveisn com as propriedades dos textos
  final String text;
  final Color color;
  final double size;
//Construtor quando a classe é chamada, ele atribui os valores iniciais
  const ModificadorTexto(
      {super.key, required this.text, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.akayaKanadaka(color: color, fontSize: size),
    );
  }
}
