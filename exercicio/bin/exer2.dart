import 'aluno.dart';

void main() {
  var aluno1 = Aluno('Fulano de Tal', '123456');
  print(aluno1);

  aluno1.lancaNota(6.3);
  aluno1.lancaNota(5.2);
  aluno1.lancaNota(9.4);
  print(aluno1);

  try {
    aluno1.notas.add(6.0);
  } catch (e) {
    print('\nErro esperado ao tentar modificar notas diretamente: $e');
  }

  print('\nEstado final do aluno após tentativa de modificação:\n  $aluno1');
}
