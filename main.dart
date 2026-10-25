import 'dart:io';

void main() {
  stdout.write('Ingresa la cédula de 10 dígitos: ');
  final entrada = stdin.readLineSync();
  if (entrada == null) return;

  final cedula = entrada.trim();
  final esValida = validarCedula(cedula);
  stdout.writeln(
    esValida ? 'La cédula es válida.' : 'La cédula no es válida.',
  );
  exitCode = esValida ? 0 : 1;
}

bool validarCedula(String cedula) {
  // La cédula debe tener exactamente 10 dígitos numéricos.
  if (cedula.length != 10 || RegExp(r'[^0-9]').hasMatch(cedula)) {
    return false;
  }

  final provincia = int.parse(cedula.substring(0, 2));
  final tercerDigito = int.parse(cedula[2]);
  if (!((provincia >= 1 && provincia <= 24) || provincia == 30)) {
    return false;
  }
  if (tercerDigito > 5 || (provincia == 30 && tercerDigito < 4)) {
    return false;
  }

  // Multiplica los primeros 9 dígitos por 2 y 1 de forma alternada.
  var suma = 0;
  for (var i = 0; i < 9; i++) {
    final digito = int.parse(cedula[i]);
    var producto = digito * (i.isEven ? 2 : 1);
    if (producto > 9) {
      producto -= 9;
    }
    suma += producto;
  }

  final digitoVerificador = (10 - suma % 10) % 10;
  return digitoVerificador == int.parse(cedula[9]);
}
