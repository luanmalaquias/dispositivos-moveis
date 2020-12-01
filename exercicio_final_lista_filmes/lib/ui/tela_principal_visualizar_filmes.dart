import 'package:exercicio_final_lista_filmes/database/filme_dao.dart';
import 'package:exercicio_final_lista_filmes/model/filme.dart';
import 'package:exercicio_final_lista_filmes/ui/tela_adicionar_filme.dart';
import 'package:exercicio_final_lista_filmes/ui/tela_detalhes_filme.dart';
import 'package:exercicio_final_lista_filmes/utility/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TelaVisualizarFilmes extends StatefulWidget {
  @override
  _TelaVisualizarFilmesState createState() => _TelaVisualizarFilmesState();
}

class _TelaVisualizarFilmesState extends State<TelaVisualizarFilmes> {
  FilmeDAO filmeDAO = FilmeDAO();
  List<Filme> _filmes = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  _appBar() {
    return AppBar(
      title: Text("Filmes"),
      actions: [
        FlatButton(
          focusColor: Colors.blue,
          child: Icon(Icons.info, color: Colors.white),
          onPressed: () {
            _mostrarIntegrantes();
          },
        ),
      ],
    );
  }

  _body() {
    return FutureBuilder<List<Filme>>(
        future: filmeDAO.select(),
        builder: (context, snapshot) {

          switch (snapshot.connectionState) {

            case ConnectionState.none:
              break;

            case ConnectionState.waiting:
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Carregando"),
                  ],
                ),
              );
              break;

            case ConnectionState.active:
              break;

            case ConnectionState.done:
              _filmes = snapshot.data;
              return ListView.builder(
                  itemCount: _filmes.length,
                  itemBuilder: (context, index) {
                    Filme filme = _filmes[index];
                    return Dismissible(
                      key: ValueKey(""),
                      child: _itemList(filme, index),
                      background: Container(
                        color: Colors.red,
                      ),
                      onDismissed: (direction){
                        setState(() {
                          filmeDAO.delete(_filmes[index].id);
                        });
                      },
                    );
                  });
              break;
          }

          return Text("Erro Desconhecido");

        });
  }

  _floatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        _onClickIrTelaCadastrarFilme();
      },
    );
  }

  Future<void> _mostrarIntegrantes() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Integrantes'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Luan dos Santos Sousa'
                    'Rodolfo Braga'
                    'Mateus Barbosa Gonzaga'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("OK")],
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _itemList(Filme filme, int index) {
    return GestureDetector(
      child: Container(
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Image.network(filme.urlImagem, width: 100),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 0, 10),
                        child: Text(filme.titulo, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Text(filme.genero, style: TextStyle(color: Colors.grey)),
                  ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Text(retornarDuracao(filme.duracao), style: TextStyle(color: Colors.grey)),
                  ),
                      SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (value) {},
                          starCount: 5,
                          rating: double.parse(filme.pontuacao.toString()),
                          size: 30.0,
                          isReadOnly: true,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_border,
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
                          spacing: 0.0),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
      onTap: () {
        _showBottomSheetOptions(index, context);
      },
    );
  }

  void _onClickIrTelaCadastrarFilme() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TelaAdicionarFilme();
    })).then((value) => { setState(() {}) });
  }

  void _onCickIrTelaAlterarFilme(Filme filme, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TelaAdicionarFilme(filme: filme);
    })).then((value) => { setState(() {}) });
  }

  _showBottomSheetOptions(int index, BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FlatButton(
                        child: Text("Alterar"),
                        onPressed: () {
                          Navigator.pop(context);
                          _onCickIrTelaAlterarFilme(_filmes[index], context);
                        },
                      ),
                      FlatButton(
                        child: Text("Detalhes"),
                        onPressed: () {
                          _onClickIrTelaDetalhesFilme(_filmes[index]);
                        },
                      )
                    ],
                  ),
                );
              });
        });
  }

  void _onClickIrTelaDetalhesFilme(Filme filme) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TelaDetalhesFilme(filme);
    })).then((value) => Navigator.pop(context));
  }

}
