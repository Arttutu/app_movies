import 'package:flutter/material.dart';
import 'descricao.dart';
import '../utils/text.dart';

class Cinemas extends StatelessWidget {
  //Construtor quando a classe é chamada, ele atribui os valores iniciais
  const Cinemas({Key? key, required this.cinemas}) : super(key: key);
  final List cinemas;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        //ajustando posição do texto
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModificadorTexto(
              text: 'Nos cinemas 🎬', color: Colors.white, size: 26),
          SizedBox(
            height: 220,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cinemas.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      //Trocar de página
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Descricao(
                                  name: cinemas[index]['title'],
                                  banner: 'https://image.tmdb.org/t/p/w500' +
                                      cinemas[index]['backdrop_path'],
                                  poster: 'https://image.tmdb.org/t/p/w500' +
                                      cinemas[index]['poster_path'],
                                  descricao: cinemas[index]['overview'] ??
                                      'Sem Descrição',
                                  nota: cinemas[index]['vote_average'],
                                  datalancamento: cinemas[index]
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
                                        cinemas[index]['backdrop_path'],
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          //ajustando o titulo do banner
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ModificadorTexto(
                                size: 20,
                                color: Colors.white,
                                text: cinemas[index]['title'] != null
                                    ? cinemas[index]['title']
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
