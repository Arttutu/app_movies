import 'package:flutter/material.dart';
import 'descricao.dart';
import '../utils/text.dart';

class ListaPopulares extends StatelessWidget {
  //Construtor quando a classe é chamada, ele atribui os valores iniciais
  const ListaPopulares({Key? key, required this.popular}) : super(key: key);
  final List popular;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        //ajustando posição do texto
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModificadorTexto(
              text: 'Séries em alta 🔥', color: Colors.white, size: 26),
          Container(
            height: 220,
            //ListView builder para fazer a lista pegando os paramentros da API
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                //.lenght pega o tamanho da lista
                itemCount: popular.length,
                //Contruido a lista
                itemBuilder: (context, index) {
                  return InkWell(
                    //OnTap permite o usuário clicar no objeto
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Descricao(
                                  name: popular[index]['name'],
                                  banner: 'https://image.tmdb.org/t/p/w500' +
                                      popular[index]['backdrop_path'],
                                  poster: 'https://image.tmdb.org/t/p/w500' +
                                      popular[index]['poster_path'],
                                  descricao: popular[index]['overview'] != null
                                      ? popular[index]['overview']
                                      : 'Falha ao carregar',
                                  nota: popular[index]['vote_average'],
                                  datalancamento: popular[index]
                                      ['first_air_date']))));
                    },
                    child: Container(
                      //margem entre os banner
                      padding: const EdgeInsets.all(5),
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
                                        popular[index]['backdrop_path'],
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
                                text: popular[index]['name'] != null
                                    ? popular[index]['name']
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
