import 'package:exercicio_final_lista_filmes/model/filme.dart';
import 'package:exercicio_final_lista_filmes/utility/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TelaDetalhesFilme extends StatefulWidget {
  Filme filme;

  TelaDetalhesFilme(this.filme);

  @override
  _TelaDetalhesFilmeState createState() => _TelaDetalhesFilmeState();
}

class _TelaDetalhesFilmeState extends State<TelaDetalhesFilme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      title: Text("Detalhes ${widget.filme.titulo}"),
    );
  }

  _body() {
    return SingleChildScrollView(
        child: Container(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Material(
                child: InkWell(
                  onTap: () {_onClickAumentarImagem(); },
                  child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(widget.filme.urlImagem, height: 300),
                      )
                  ),
                )
            ),
          ]),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.filme.titulo,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            Text(widget.filme.genero,
                                style: TextStyle(color: Colors.grey)),
                            Text(retornarDuracao(widget.filme.duracao),
                                style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.filme.ano.toString(),
                              style: TextStyle(color: Colors.grey)),
                          Text(verificarFaixaEtaria(widget.filme.faixaEtaria),
                              style: TextStyle(color: Colors.grey)),
                          SmoothStarRating(
                              allowHalfRating: false,
                              onRated: (value) {},
                              starCount: 5,
                              rating: double.parse(widget.filme.pontuacao.toString()),
                              size: 25.0,
                              isReadOnly: true,
                              filledIconData: Icons.star,
                              halfFilledIconData: Icons.star_border,
                              color: Colors.yellow,
                              borderColor: Colors.yellow,
                              spacing: 0.0),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.filme.descricao),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Future<void> _onClickAumentarImagem() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Image.network(widget.filme.urlImagem, fit: BoxFit.fitWidth);
      },
    );
  }
}
