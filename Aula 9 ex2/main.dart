import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(PetAgeApp());

class PetAgeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Idade Fisiológica Pet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F7FA),
        primaryColor: Color(0xFF5A72FF),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF5A72FF),
          secondary: Color(0xFF29C6A0),
        ),
        textTheme: TextTheme(
          headline5: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xFF223263)),
          bodyText2: TextStyle(fontSize: 16, color: Color(0xFF9098B1)),
          headline4: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
              color: Color(0xFF223263)),
        ),
      ),
      home: PetAgeHomePage(),
    );
  }
}

class PetAgeHomePage extends StatefulWidget {
  @override
  _PetAgeHomePageState createState() => _PetAgeHomePageState();
}

class _PetAgeHomePageState extends State<PetAgeHomePage> {
  String petType = 'Cachorro'; // Opções: Cachorro ou Gato
  double weight = 5;
  int age = 1;

  double calculateHumanAge() {
    if (petType == 'Cachorro') {
      if (weight <= 10) {
        return 16 * log(age.toDouble()) + 31;
      } else {
        return 12 * log(age.toDouble()) + 30;
      }
    } else {
      if (age == 1) return 15;
      if (age == 2) return 24;
      if (age > 2) return 24 + (age - 2) * 4;
      return 0;
    }
  }

  void onPetTypeChanged(String? val) {
    if (val == null) return;
    setState(() {
      petType = val;
      weight = petType == 'Cachorro' ? 5 : 3;
      age = 1;
    });
  }

  void incrementAge() {
    if (age < 30) {
      setState(() {
        age++;
      });
    }
  }

  void decrementAge() {
    if (age > 1) {
      setState(() {
        age--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final humanAge = calculateHumanAge();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Idade Fisiológica Pet',
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tipo de Pet', style: theme.textTheme.bodyText2),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3))
                ],
              ),
              child: DropdownButton<String>(
                value: petType,
                isExpanded: true,
                underline: SizedBox(),
                items: ['Cachorro', 'Gato']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: onPetTypeChanged,
              ),
            ),
            SizedBox(height: 32),
            Text('Peso (kg): ${weight.toStringAsFixed(1)}',
                style: theme.textTheme.bodyText2),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: theme.colorScheme.secondary,
                inactiveTrackColor: theme.colorScheme.secondary.withAlpha(80),
                thumbColor: theme.colorScheme.secondary,
                overlayColor: theme.colorScheme.secondary.withAlpha(32),
                valueIndicatorColor: theme.colorScheme.secondary,
                trackHeight: 6,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 14),
              ),
              child: Slider(
                min: petType == 'Cachorro' ? 1 : 1,
                max: petType == 'Cachorro' ? 60 : 10,
                divisions: petType == 'Cachorro' ? 59 : 9,
                label: '${weight.toStringAsFixed(1)} kg',
                value: weight,
                onChanged: (val) => setState(() => weight = val),
              ),
            ),
            SizedBox(height: 32),
            Text('Idade (anos)', style: theme.textTheme.bodyText2),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: decrementAge,
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                    backgroundColor: theme.primaryColor,
                  ),
                  child: Icon(Icons.remove, size: 28),
                ),
                SizedBox(width: 32),
                Text(
                  '$age',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                SizedBox(width: 32),
                ElevatedButton(
                  onPressed: incrementAge,
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                    backgroundColor: theme.primaryColor,
                  ),
                  child: Icon(Icons.add, size: 28),
                ),
              ],
            ),
            Spacer(),
            Center(
              child: Column(
                children: [
                  Text(
                    'Idade fisiológica em anos humanos',
                    style: theme.textTheme.headline5,
                  ),
                  SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
                    child: Text(
                      humanAge.isNaN || humanAge.isInfinite
                          ? 'Valor inválido'
                          : humanAge.toStringAsFixed(1),
                      style: theme.textTheme.headline4?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
