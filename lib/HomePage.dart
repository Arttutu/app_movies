import 'package:meuapp/utils/shearbar.dart';
import 'api_cofing/variaveis_constantes.dart';
import 'utils/text.dart';
import 'widgets/popular_tv.dart';
import '../widgets/Em_Breve.dart';
import '../widgets/Nos_Cinemas.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageSatate();
}

// herdando Home page e definindo com State, ou seja. muda o seu estado.
class HomePageSatate extends State<HomePage> {
  dynamic peganforeposta;

  @override
  void initState() {
    carregarFilmes();
    super.initState();
  }

  carregarFilmes() async {
    // instanciando o objeto TMDB , passando sua chave e seu token de acesso.
    TMDB pegandoresposta = TMDB(ApiKeys(key, token), defaultLanguage: 'pt-BR');

    LogConfig:
    const ConfigLogger(showErrorLogs: true, showLogs: true);

    //Acessando os dados da api  através de Chave e valor {key, valor}

    Map embrevemoviesresults = await pegandoresposta.v3.movies.getUpcoming();
    Map noscinemasresults = await pegandoresposta.v3.movies.getNowPlaying();
    Map popularseriesresults = await pegandoresposta.v3.tv.getPopular();

    //SetState Informa que o estado da aplicação mudou.

    setState(() {
      nosCinemas = noscinemasresults['results'];
      emBreveMovies = embrevemoviesresults['results'];
      popularseries = popularseriesresults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //AppBar Cabeçalho.
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const ModificadorTexto(
            text: 'Seus filmes e séries favoritos ❤️',
            color: Colors.white,
            size: 25),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: Pesquisar(),
                );
              },
              icon: const Icon(Icons.search_rounded))
        ],
      ),

      //Corpo do aplicativo
      //Listview mostra os intens da lista.

      body: ListView(
        children: [
          ListaPopulares(popular: popularseries),
          EmBreve(breve: emBreveMovies),
          Cinemas(cinemas: nosCinemas),
        ],
      ),
    );
  }
}
