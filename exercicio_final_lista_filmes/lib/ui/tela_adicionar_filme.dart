import 'package:exercicio_final_lista_filmes/database/filme_dao.dart';
import 'package:exercicio_final_lista_filmes/model/filme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TelaAdicionarFilme extends StatefulWidget {
  Filme filme = null;

  TelaAdicionarFilme({this.filme});

  @override
  _TelaAdicionarFilmeState createState() => _TelaAdicionarFilmeState();
}

class _TelaAdicionarFilmeState extends State<TelaAdicionarFilme> {
  TextEditingController _edtUrl = TextEditingController();
  TextEditingController _edtTitulo = TextEditingController();
  TextEditingController _edtGenero = TextEditingController();
  int _faitaEtaria = 0;
  TextEditingController _edtDuracao = TextEditingController();
  double _pontuacao = 0;
  TextEditingController _edtAno = TextEditingController();
  TextEditingController _edtDescricao = TextEditingController();

  @override
  void initState() {
    super.initState();
    _edtUrl.text = (widget.filme != null) ? widget.filme.urlImagem : "";
    _edtTitulo.text = (widget.filme != null) ? widget.filme.titulo : "";
    _edtGenero.text = (widget.filme != null) ? widget.filme.genero : "";
    _faitaEtaria = (widget.filme != null) ? widget.filme.faixaEtaria : 0;
    _edtDuracao.text = (widget.filme != null) ? widget.filme.duracao.toString() : "";
    _pontuacao = (widget.filme != null) ? widget.filme.pontuacao.toDouble() : 0;
    _edtAno.text = (widget.filme != null) ? widget.filme.ano.toString() : "";
    _edtDescricao.text = (widget.filme != null) ? widget.filme.descricao : "";
  }

  FilmeDAO _filmeDAO = FilmeDAO();

  final _formKey = GlobalKey<FormState>();

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
      title: Text("Cadastrar"),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _edtUrl,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(labelText: "Url Imagem"),
                validator: (value) => (value.isEmpty) ? "Informe a url" : null,
              ),
              TextFormField(
                controller: _edtTitulo,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Titulo"),
                validator: (value) =>
                    (value.isEmpty) ? "Informe o Titulo" : null,
              ),
              TextFormField(
                controller: _edtGenero,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Gênero"),
                validator: (value) =>
                    (value.isEmpty) ? "Informe o Gênero" : null,
              ),
              Row(
                children: [
                  Text("Faixa Etária:  ",
                      style: TextStyle(fontSize: 17, color: Colors.grey)),
                  DropdownButton(
                      value: _faitaEtaria,
                      items: [
                        DropdownMenuItem(
                          child: Text("Livre"),
                          value: 0,
                        ),
                        DropdownMenuItem(child: Text("10 anos"), value: 10),
                        DropdownMenuItem(child: Text("12 anos"), value: 12),
                        DropdownMenuItem(child: Text("14 anos"), value: 14),
                        DropdownMenuItem(child: Text("16 anos"), value: 16),
                        DropdownMenuItem(child: Text("18 anos"), value: 18)
                      ],
                      onChanged: (value) {
                        setState(() {
                          _faitaEtaria = value;
                        });
                      }),
                ],
              ),
              TextFormField(
                controller: _edtDuracao,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Duração (h)"),
                validator: (value) =>
                    (value.isEmpty) ? "Informe a Duração" : null,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                child: Row(
                  children: [
                    Text("Nota: ",
                        style: TextStyle(fontSize: 17, color: Colors.grey)),
                    SmoothStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      rating: _pontuacao,
                      size: 30.0,
                      isReadOnly: false,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_border,
                      color: Colors.blue,
                      borderColor: Colors.blue,
                      spacing: 0.0,
                      onRated: (value) {
                        _pontuacao = value;
                      },
                    )
                  ],
                ),
              ),
              TextFormField(
                controller: _edtAno,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Ano"),
                validator: (value) => (value.isEmpty) ? "Informe o Ano" : null,
              ),
              TextFormField(
                maxLines: 2,
                controller: _edtDescricao,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Descrição"),
                validator: (value) =>
                    (value.isEmpty) ? "Informe a Descrição" : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.save),
      onPressed: () {
        _onClickSaveFilme();
      },
    );
  }

  void _onClickSaveFilme() {
    bool validacao = _formKey.currentState.validate();

    if (!validacao) return;

    if (widget.filme == null) {
      _filmeDAO
          .insert(Filme(
              urlImagem: _edtUrl.text,
              titulo: _edtTitulo.text,
              genero: _edtGenero.text,
              duracao: double.parse(_edtDuracao.text),
              faixaEtaria: _faitaEtaria,
              pontuacao: _pontuacao.toInt(),
              ano: int.parse(_edtAno.text),
              descricao: _edtDescricao.text))
          .then((value) => {Navigator.pop(context)});
    } else {
      _filmeDAO
          .update(Filme(
              id: widget.filme.id,
              urlImagem: _edtUrl.text,
              titulo: _edtTitulo.text,
              genero: _edtGenero.text,
              duracao: double.parse(_edtDuracao.text),
              faixaEtaria: _faitaEtaria,
              pontuacao: _pontuacao.toInt(),
              ano: int.parse(_edtAno.text),
              descricao: _edtDescricao.text))
          .then((value) => {Navigator.pop(context)});
    }
  }
}
