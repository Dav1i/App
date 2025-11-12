import 'package:geolocator/geolocator.dart';

class Localizacao {
  double? latitude;
  double? longitude;

  // Método que pega a localização atual
  Future<void> pegaLocalizacaoAtual() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
  }
}
