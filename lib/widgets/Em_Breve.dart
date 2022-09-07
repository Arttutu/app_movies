import 'package:flutter/material.dart';
import 'descricao.dart';
import '../utils/text.dart';

class EmBreve extends StatelessWidget {
  //Construtor quando a classe é chamada, ele atribui os valores iniciais
  const EmBreve({Key? key, required this.breve}) : super(key: key);
  final List breve;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        //ajustando posição do texto
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModificadorTexto(
              text: 'Em breve ', color: Colors.white, size: 26),
          Container(
            height: 220,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: breve.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      //Trocar de página
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Descricao(
                                  name: breve[index]['title'],
                                  banner: 'https://image.tmdb.org/t/p/w500' +
                                      breve[index]['backdrop_path'],
                                  poster: 'https://image.tmdb.org/t/p/w500' +
                                      breve[index]['poster_path'],
                                  descricao: breve[index]['overview'],
                                  nota: breve[index]['vote_average'],
                                  datalancamento: breve[index]
                                      ['release_date']))));
                    },
                    child: Container(
                      //margem entre os banner
                      padding: EdgeInsets.all(5),
                      //Largura total
                      width: 250,
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        breve[index]['backdrop_path'],
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          //ajustando o titulo do banner
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ModificadorTexto(
                                size: 20,
                                color: Colors.white,
                                text: breve[index]['title'] != null
                                    ? breve[index]['title']
                                    : 'loanding'),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
