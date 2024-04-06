import 'package:logger/logger.dart';

// Clase Logs para manejar registros de logs
class Logs {
  Logs._internal(); // Constructor privado para garantizar que la clase no se pueda instanciar fuera de sí misma

  final Logger _logger = Logger(); // Instancia de Logger para el manejo de logs

  static Logs _instance = Logs._internal(); // Instancia única de Logs utilizando el constructor privado
  static Logger get p => _instance._logger; // Getter estático para acceder a la instancia de Logger

  // Método estático para obtener la instancia de Logger
  static Logger get loggerInstance => _instance._logger;
}
