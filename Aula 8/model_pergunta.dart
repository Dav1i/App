class Pergunta {
  final String enunciado;
  final List<String> alternativas;
  final int indiceCorreto;

  Pergunta({
    required this.enunciado,
    required this.alternativas,
    required this.indiceCorreto,
  });
}

final List<Pergunta> perguntas = [
  Pergunta(
    enunciado: 'Qual é a capital da França?',
    alternativas: ['Berlim', 'Madrid', 'Paris', 'Roma'],
    indiceCorreto: 2,
  ),
  Pergunta(
    enunciado: 'Quem escreveu "Dom Quixote"?',
    alternativas: [
      'Shakespeare',
      'Cervantes',
      'Machado de Assis',
      'Dostoiévski'
    ],
    indiceCorreto: 1,
  ),
  Pergunta(
    enunciado: 'Maior planeta do sistema solar?',
    alternativas: ['Terra', 'Marte', 'Júpiter', 'Saturno'],
    indiceCorreto: 2,
  ),
  Pergunta(
    enunciado: 'Ano da Revolução Francesa?',
    alternativas: ['1776', '1789', '1812', '1848'],
    indiceCorreto: 1,
  ),
  Pergunta(
    enunciado: 'Quem pintou a Mona Lisa?',
    alternativas: ['Van Gogh', 'Picasso', 'Da Vinci', 'Monet'],
    indiceCorreto: 2,
  ),
  Pergunta(
    enunciado: 'Rio mais longo do mundo?',
    alternativas: ['Amazonas', 'Nilo', 'Yangtzé', 'Mississippi'],
    indiceCorreto: 1,
  ),
  Pergunta(
    enunciado: 'Primeiro presidente dos EUA?',
    alternativas: ['Lincoln', 'Jefferson', 'Washington', 'Adams'],
    indiceCorreto: 2,
  ),
  Pergunta(
    enunciado: 'País mais populoso?',
    alternativas: ['Índia', 'China', 'EUA', 'Indonésia'],
    indiceCorreto: 1,
  ),
  Pergunta(
    enunciado: 'Fórmula da água?',
    alternativas: ['CO2', 'H2O', 'O2', 'NaCl'],
    indiceCorreto: 1,
  ),
  Pergunta(
    enunciado: 'Símbolo do oxigênio?',
    alternativas: ['O', 'Ox', 'Og', 'Om'],
    indiceCorreto: 0,
  ),
];
