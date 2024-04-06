import 'package:flutter_api_rest/helpers/http.dart' show Http; 
import 'package:flutter_api_rest/helpers/http_response.dart' show HttpResponse;
import 'package:flutter_api_rest/models/authentication_response.dart';

class AuthenticationAPI {
  final Http _http; // Instancia de la clase Http para realizar solicitudes HTTP

  AuthenticationAPI(this._http); // Constructor que recibe una instancia de Http

  Future<HttpResponse> register({ // Método para registrarse
    required String username,
    required String email,
    required String password,
  }) {
    return _http.request<AuthenticationResponse>( // Realizar una solicitud HTTP para registrar un usuario
      '/api/v1/register',
      method: "POST",
      data: {
        "username": username,
        "email": email,
        "password": password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data); // Analizar la respuesta y convertirla en un objeto AuthenticationResponse
      }, queryParameters: {}, formData: {}, headers: {},
    );
  }

  Future<HttpResponse> login({ // Método para iniciar sesión
    required String email,
    required String password,
  }) async {
    return _http.request<AuthenticationResponse>( // Realizar una solicitud HTTP para iniciar sesión
      '/api/v1/login',
      method: "POST",
      data: {
        "email": email,
        "password": password,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data); // Analizar la respuesta y convertirla en un objeto AuthenticationResponse
      }, queryParameters: {}, formData: {}, headers: {},
    );
  }

  Future<HttpResponse> refreshToken(String expiredToken) { // Método para actualizar el token de acceso
    return _http.request<AuthenticationResponse>( // Realizar una solicitud HTTP para actualizar el token de acceso
      '/api/v1/refresh-token',
      method: "POST",
      headers: {
        "token": expiredToken,
      },
      parser: (data) {
        return AuthenticationResponse.fromJson(data); // Analizar la respuesta y convertirla en un objeto AuthenticationResponse
      }, queryParameters: {}, data: {}, formData: {},
    );
  }
}
