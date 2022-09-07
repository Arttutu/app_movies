import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meuapp/utils/size_config.dart';
import 'package:meuapp/utils/text.dart';
import '../api_cofing/variaveis_constantes.dart';
import "package:http/http.dart" as http;
import '../widgets/descricao.dart';
import '../models/movies_and_series.model.dart';

//Class SearchDeleganteb traz todos os parâmetros que precisamos para fazer a pesquisa!
class Pesquisar extends SearchDelegate {
  @override
  //Sugestão para o usuário pesquisar.
  String get searchFieldLabel => ' Pesquisar';
  List<Widget>? buildActions(BuildContext context) {
    //
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
    //////////////////////////////////////////////////////////////////////////
    final sizeConfig = SizeConfig(mediaQueryData: MediaQuery.of(context));
    final PosterRequest _posterRequest = PosterRequest();
    //////////////////////////////////////////////////////////////

    return FutureBuilder<MoviesAndSeriesModel>(
      future: _posterRequest.getSearchMoviesAndSeries(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          MoviesAndSeriesModel? film = snapshot.data;
          return Container(
              child: Column(
            //ajustando posição do texto
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: sizeConfig.dynamicScaleSize(size: 600),
                width: sizeConfig.dynamicScaleSize(size: 400),
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    //pega o tamanho da query
                    //pega o tamanho da query
                    itemCount: film?.results?.length,
                    itemBuilder: (context, index) {
                      var imageUrl = film?.results?[index].posterPath;
                      var texturl_serie = film?.results?[index].name;
                      var texturl_filme = film?.results?[index].title;

                      return Column(
                        children: [
                          Row(
                            children: [
                              imageUrl != null
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    Descricao(
                                                        name: film
                                                                ?.results?[
                                                                    index]
                                                                .title ??
                                                            '',
                                                        banner: film
                                                            ?.results?[index]
                                                            .backdropPath,
                                                        poster: film
                                                            ?.results?[index].posterPath,
                                                        ,
                                                        descricao: film
                                                                ?.results?[
                                                                    index]
                                                                .overview ??
                                                            '',
                                                        nota: film
                                                            ?.results?[index]
                                                            .voteAverage,
                                                        datalancamento: film
                                                                ?.results?[
                                                                    index]
                                                                .releaseDate ??
                                                            ''))));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
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
                              Visibility(
                                visible: texturl_filme != null,
                                child: Flexible(
                                  child: Container(
                                    child: texturl_filme == null
                                        ? Container()
                                        : ModificadorTexto(
                                            color: Colors.white,
                                            size: 20,
                                            text: texturl_filme),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: texturl_serie != null,
                                child: Flexible(
                                  child: Container(
                                    child: texturl_serie == null
                                        ? Container()
                                        : ModificadorTexto(
                                            color: Colors.white,
                                            size: 20,
                                            text: texturl_serie),
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
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 5,
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

  inkWel() {}
}

class PosterRequest {
  dynamic response;
  Future<MoviesAndSeriesModel> getSearchMoviesAndSeries(String query) async {
    try {
      response = await http
          .get(Uri.parse('$url/3/search/multi?api_key=$key&query=$query'));

      if (query != '') {
        if (response.statusCode == 200 && query != '') {
          return MoviesAndSeriesModel.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Failed to load album');
        }
      }
      return MoviesAndSeriesModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      print('não foi possivel obter o fazer a pesquisa $e');
      rethrow;
    }
  }
}
