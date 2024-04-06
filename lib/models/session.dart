class Session {
  final String token; // Token de la sesión
  final int expiresIn; // Tiempo de expiración de la sesión
  final DateTime createdAt; // Fecha y hora de creación de la sesión

  Session({
    required this.token, // Token requerido al construir la sesión
    required this.expiresIn, // Tiempo de expiración requerido al construir la sesión
    required this.createdAt, // Fecha y hora de creación requerida al construir la sesión
  });

  static Session fromJson(Map<String, dynamic> json) {
    return Session(
      token: json['token'], // Obtener el token del mapa JSON
      expiresIn: json['expiresIn'], // Obtener el tiempo de expiración del mapa JSON
      createdAt: DateTime.parse(json['createdAt']), // Convertir la cadena de fecha y hora en un objeto DateTime
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token, // Agregar el token al mapa JSON
      "expiresIn": expiresIn, // Agregar el tiempo de expiración al mapa JSON
      "createdAt": createdAt.toIso8601String(), // Convertir la fecha y hora a una cadena ISO8601 y agregar al mapa JSON
    };
  }
}
