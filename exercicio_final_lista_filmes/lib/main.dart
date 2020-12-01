import 'package:exercicio_final_lista_filmes/ui/tela_principal_visualizar_filmes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TelaVisualizarFilmes(),
    debugShowCheckedModeBanner: false,
  ));

  /*FilmeDAO filmeDAO = FilmeDAO();

  Filme f1 = Filme(
      id: 1,
      urlImagem: "https://i.pinimg.com/736x/2e/3a/93/2e3a938ff397d3280755defa41baa150.jpg",
      titulo: "Jumanj",
      genero: "Terror",
      faixaEtaria: 18,
      duracao: 2.3,
      pontuacao: 2,
      descricao: "Um filme legal que lançou dia tal teste teste teste de pixels",
      ano: 2020
  );

  Filme f2 = Filme(
      id: 2,
      urlImagem: "https://lojasaraiva.vteximg.com.br/arquivos/ids/12710394/1006692973.jpg",
      titulo: "Inferno",
      genero: "Drama, Terror e Ação",
      faixaEtaria: 16,
      duracao: 1.6,
      pontuacao: 1,
      descricao: "Duas pessas estão sendo perseguidas por ovnis esasiasuhas teste teste",
      ano: 2016
  );

  //filmeDAO.insert(f1).then((value) => debugPrint("Inserido"));
  //filmeDAO.insert(f2).then((value) => debugPrint("Inserido"));
  //filmeDAO.update(f1).then((value) => debugPrint("Atualizado"));
  //filmeDAO.delete(1).then((value) => debugPrint("Deletado"));
  //filmeDAO.deleteAll().then((value) => debugPrint("Todos deletados"));

  //filmeDAO.selectOne("Titanic");
  //filmeDAO.select();*/
}