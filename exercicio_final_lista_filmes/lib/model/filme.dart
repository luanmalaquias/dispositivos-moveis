class Filme{

  int id;
  String urlImagem;
  String titulo;
  String genero;
  int faixaEtaria;
  double duracao;
  int pontuacao;
  String descricao;
  int ano;

  Filme({
    this.id, this.urlImagem, this.titulo, this.genero, this.faixaEtaria,
    this.duracao, this.pontuacao, this.descricao, this.ano
  });

  @override
  String toString() {
    return '$id, $urlImagem, $titulo, $genero, $faixaEtaria, $duracao, $pontuacao, $descricao, $ano';
  }
}