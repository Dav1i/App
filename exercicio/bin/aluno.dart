class Aluno {
  final String nome;
  final String matricula;
  final List<double> _notas;

  Aluno(this.nome, this.matricula) : _notas = [];

  List<double> get notas => List.unmodifiable(_notas);

  void lancaNota(double nota) {
    _notas.add(nota);
  }

  @override
  String toString() {
    return '\nAluno: $nome, \n  Matrícula: $matricula, \n  Notas: $_notas\n';
  }
}
