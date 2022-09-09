import 'package:flutter/material.dart';
import 'package:meuapp/utils/text.dart';
import '../utils/text.dart';

class Descricao extends StatelessWidget {
  final String name, descricao, banner, poster, datalancamento;
  final dynamic nota;

  const Descricao(
      {super.key,
      required this.name,
      required this.descricao,
      required this.nota,
      required this.banner,
      required this.poster,
      required this.datalancamento});

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////////////
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              //Alutura
              height: 250,
              ////////////////////////////////
              child: Stack(
                // posicionamento do poster do banneer
                children: [
                  Positioned(
                      child: Container(
                    height: 250,
                    //Obtem o tamanho da tela do dispositivo em que você está
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      banner,
                      fit: BoxFit.cover,
                    ),
                  )),
                  Positioned(
                    bottom: 10,
                    child: ModificadorTexto(
                      text: '⭐Nota - $nota',
                      size: 26,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            //////////////////////////////////////////////////////////////
            Container(
              padding: EdgeInsets.all(10),
              child: ModificadorTexto(
                  text: name != null ? name : 'loading',
                  size: 26,
                  color: Colors.white),
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: ModificadorTexto(
                    text: 'Data de lançamento - ' + datalancamento,
                    size: 23,
                    color: Colors.white)),
            //////////////////////////////////////////////////////////////
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: Image.network(poster),
                ),
                //////////////////////////////////////////////////////////////
                Flexible(
                  child: Container(
                    child: ModificadorTexto(
                      text: descricao,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
