import 'package:flutter/material.dart';
import 'package:meuapp/api_cofing/variaveis_constantes.dart';
import 'package:meuapp/utils/size_config.dart';
import 'package:meuapp/utils/text.dart';
import '../api_cofing/chamada_api.dart';
import '../widgets/descricao.dart';
import '../models/movies_and_series.model.dart';

//Class SearchDeleganteb traz todos os parâmetros que precisamos para fazer a pesquisa!
class Pesquisar extends SearchDelegate {
  @override
  //Sugestão para o usuário pesquisar.
  String get searchFieldLabel => ' Pesquisar';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          //atributo query muda o estado da string
          query = '';
        },
        //botão de deletar itens de busca.
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      //Fecha o campode pesquisa e volta para a tela inicial
      onPressed: () {
        close(context, '');
      },
      //botão da flecha de voltar
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // instanciando as classes
    final sizeConfig = SizeConfig(mediaQueryData: MediaQuery.of(context));
    final PosterRequest posterRequest = PosterRequest();

    return FutureBuilder<MoviesAndSeriesModel>(
      future: posterRequest.getSearchMoviesAndSeries(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          MoviesAndSeriesModel? film = snapshot.data;
          return Container(
              color: Colors.black,
              child: Column(
                //ajustando posição do texto
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: sizeConfig.dynamicScaleSize(size: 600),
                    width: sizeConfig.dynamicScaleSize(size: 600),
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        //pega o tamanho da query
                        //pega o tamanho da query
                        itemCount: film?.results?.length,
                        itemBuilder: (context, index) {
                          var pessoaurl = film?.results?[index].mediaType;
                          var imageUrl = film?.results?[index].posterPath;
                          var texturlSerie = film?.results?[index].name;
                          var texturlFilme = film?.results?[index].title;

                          return Column(
                            children: [
                              Row(
                                children: [
                                  //ternário para verificar se a imagem é null se for nula retorna um Conteiner vazio.
                                  imageUrl != null
                                      // Inkel Splash efeito quando vc clica em um objeto na tela
                                      ? InkWell(
                                          //OnTap permite o usuário clicar no objeto
                                          onTap: () {
                                            //troca de página
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) => Descricao(
                                                        name: film
                                                                ?.results?[
                                                                    index]
                                                                .title ??
                                                            'Sem titulo',
                                                        banner: urlimage +
                                                            film
                                                                ?.results?[
                                                                    index]
                                                                .backdropPath,
                                                        poster: urlimage +
                                                            film
                                                                ?.results?[
                                                                    index]
                                                                .posterPath,
                                                        descricao: film
                                                                ?.results?[
                                                                    index]
                                                                .overview ??
                                                            'Sem Descrição',
                                                        nota: film
                                                            ?.results?[index]
                                                            .voteAverage,
                                                        datalancamento: film
                                                                ?.results?[index]
                                                                .releaseDate ??
                                                            'Sem data de lançamento'))));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            height: 300,
                                            width: 200,
                                            child: imageUrl == null
                                                ? Container()
                                                : Image(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        'https://image.tmdb.org/t/p/original/$imageUrl')),
                                          ),
                                        )
                                      : Container(),
                                  //visibility faz a seleção do nome da serie e do filme. não mostrando quando for nulo.
                                  Visibility(
                                    visible: texturlFilme != null,
                                    child: Flexible(
                                      child: Container(
                                        child: texturlFilme == null
                                            ? Container()
                                            : ModificadorTexto(
                                                color: Colors.white,
                                                size: 20,
                                                text: texturlFilme),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: texturlSerie != null &&
                                        pessoaurl == 'tv',
                                    //Flexible adapta o texto com a imagem
                                    child: Flexible(
                                      child: Container(
                                        child: texturlSerie == null
                                            ? Container()
                                            : ModificadorTexto(
                                                color: Colors.white,
                                                size: 20,
                                                text: texturlSerie),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ));
        } else if (snapshot.hasError) {
          return const Center(child: Icon(Icons.refresh));
        }
        //animação de loading na tela de busca.
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 10,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Text('pesquise algum filme ou série!',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
