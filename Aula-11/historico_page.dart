import 'package:flutter/material.dart';
import 'database_helper.dart';

class HistoricoPage extends StatelessWidget {
  const HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Operações')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.listarOperacoes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          final dados = snapshot.data!;
          if (dados.isEmpty)
            return const Center(child: Text('Nenhuma operação registrada.'));

          return ListView.builder(
            itemCount: dados.length,
            itemBuilder: (_, i) {
              final op = dados[i];
              return ListTile(
                title: Text(op['expressao']),
                subtitle: Text('Resultado: ${op['resultado']}'),
                trailing: Text(op['data'].toString().split('T').first),
              );
            },
          );
        },
      ),
    );
  }
}
