String retornarDuracao(double duracao) {
  int horas = duracao.toInt();
  int minutos = ((duracao - (duracao.toInt())) * 100).toInt();

  return "$horas\h ${minutos}\min";
}

String verificarFaixaEtaria(int faixaEtaria) {
  if (faixaEtaria == 0)
    return "Livre";
  else
    return "$faixaEtaria anos";
}
