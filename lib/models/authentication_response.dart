class AuthenticationResponse {
  final String token; // Token de autenticación
  final int expiresIn; // Tiempo de expiración del token

  AuthenticationResponse({
    required this.token, // Token requerido al construir la respuesta de autenticación
    required this.expiresIn, // Tiempo de expiración requerido al construir la respuesta de autenticación
  });

  static AuthenticationResponse fromJson(Map<String, dynamic> json) {
    return AuthenticationResponse(
      token: json['token'], // Obtener el token del mapa JSON
      expiresIn: json['expiresIn'], // Obtener el tiempo de expiración del mapa JSON
    );
  }
}
