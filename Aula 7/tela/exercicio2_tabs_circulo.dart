import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: CircleTabs()));
}

class CircleTabs extends StatefulWidget {
  @override
  _CircleTabsState createState() => _CircleTabsState();
}

class _CircleTabsState extends State<CircleTabs>
    with SingleTickerProviderStateMixin {
  double raio = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Círculo"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Raio"),
              Tab(text: "Diâmetro"),
              Tab(text: "Circ."),
              Tab(text: "Área"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Raio
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Raio"),
                onChanged: (v) =>
                    setState(() => raio = double.tryParse(v) ?? 0),
              ),
            ),

            Center(child: Text("Diâmetro = ${(2 * raio).toStringAsFixed(2)}")),
            Center(
                child: Text(
                    "Circunf. = ${(2 * 3.14159 * raio).toStringAsFixed(2)}")),
            Center(
                child: Text(
                    "Área = ${(3.14159 * raio * raio).toStringAsFixed(2)}")),
          ],
        ),
      ),
    );
  }
}
