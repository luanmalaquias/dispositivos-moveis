import 'package:exercicio_final_lista_filmes/database/conexao_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:exercicio_final_lista_filmes/model/filme.dart';

class FilmeDAO {
  static const String tabelaFilmes = "filmes";
  static const String colunaId = "id";
  static const String colunaUrlImagem = "urlImagem";
  static const String colunaTitulo = "titulo";
  static const String colunaGenero = "genero";
  static const String colunaFaixaEtaria = "faixaEtaria";
  static const String colunaDuracao = "duracao";
  static const String colunaPontuacao = "pontuacao";
  static const String colunaDescricao = "descricao";
  static const String colunaAno = "ano";

  static const String criarTabelaFilmes = "CREATE TABLE filmes("
      "$colunaId INTEGER PRIMARY KEY,"
      "$colunaUrlImagem TEXT,"
      "$colunaTitulo TEXT,"
      "$colunaGenero TEXT,"
      "$colunaFaixaEtaria INT,"
      "$colunaDuracao DOUBLE,"
      "$colunaPontuacao INT,"
      "$colunaDescricao TEXT,"
      "$colunaAno INT)";

  Future<int> insert(Filme filme) async {

    Database db = await getDataBase();

    Map<String, dynamic> mapFilme = Map();
    mapFilme[colunaUrlImagem] = filme.urlImagem;
    mapFilme[colunaTitulo] = filme.titulo;
    mapFilme[colunaGenero] = filme.genero;
    mapFilme[colunaFaixaEtaria] = filme.faixaEtaria;
    mapFilme[colunaDuracao] = filme.duracao;
    mapFilme[colunaPontuacao] = filme.pontuacao;
    mapFilme[colunaDescricao] = filme.descricao;
    mapFilme[colunaAno] = filme.ano;

    return db.insert(tabelaFilmes, mapFilme);
  }

  Future<int> update(Filme filme) async {
    Database db = await getDataBase();

    Map<String, dynamic> mapFilme = Map();
    mapFilme[colunaUrlImagem] = filme.urlImagem;
    mapFilme[colunaTitulo] = filme.titulo;
    mapFilme[colunaGenero] = filme.genero;
    mapFilme[colunaFaixaEtaria] = filme.faixaEtaria;
    mapFilme[colunaDuracao] = filme.duracao;
    mapFilme[colunaPontuacao] = filme.pontuacao;
    mapFilme[colunaDescricao] = filme.descricao;
    mapFilme[colunaAno] = filme.ano;

    return db.update(tabelaFilmes, mapFilme, where: "id = ?", whereArgs: [filme.id]);
  }

  Future<int> delete(int id) async {
    Database db = await getDataBase();
    return db.delete(tabelaFilmes, where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database db = await getDataBase();
    return db.delete(tabelaFilmes);
  }

  Future<List<Filme>> select() async {

    Database db = await getDataBase();

    List<Map<String, dynamic>> mapFilmes = await db.query(tabelaFilmes);
    List<Filme> filmes = List();

    for(Map<String, dynamic> map in mapFilmes){
      Filme filme = Filme(
        id: map[colunaId],
        urlImagem: map[colunaUrlImagem],
        titulo: map[colunaTitulo],
        genero: map[colunaGenero],
        faixaEtaria: map[colunaFaixaEtaria],
        duracao: map[colunaDuracao],
        pontuacao: map[colunaPontuacao],
        descricao: map[colunaDescricao],
        ano: map[colunaAno],
      );
      filmes.add(filme);
    }

    return filmes;
  }

  Future<List<Filme>> selectOne(String titulo) async {

    Database db = await getDataBase();

    List<Map<String, dynamic>> mapFilmes = await db.query(tabelaFilmes, where: "titulo = ?", whereArgs: [titulo]);
    List<Filme> filmes = List();

    for(Map<String, dynamic> map in mapFilmes){
      Filme filme = Filme(
        id: map[colunaId],
        urlImagem: map[colunaUrlImagem],
        titulo: map[colunaTitulo],
        genero: map[colunaGenero],
        faixaEtaria: map[colunaFaixaEtaria],
        duracao: map[colunaDuracao],
        pontuacao: map[colunaPontuacao],
        descricao: map[colunaDescricao],
        ano: map[colunaAno],
      );
      filmes.add(filme);
    }

    return filmes;
  }
}