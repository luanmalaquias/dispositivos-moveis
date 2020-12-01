import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'filme_dao.dart';

Future<Database> getDataBase() async {
  String dbpath = await getDatabasesPath();
  String path = join(dbpath, 'Banco.db');
  return openDatabase(path, onCreate: (db, version){
    db.execute(FilmeDAO.criarTabelaFilmes);
  }, version: 1);
}