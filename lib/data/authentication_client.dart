import 'dart:async';
import 'dart:convert';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/models/authentication_response.dart'; 
import 'package:flutter_api_rest/models/session.dart'; 
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 

class AuthenticationClient {
  final FlutterSecureStorage _secureStorage; // Instancia de almacenamiento seguro
  final AuthenticationAPI _authenticationAPI; // Instancia de la API de autenticación
  Completer _completer = Completer(); // Objeto para manejo de completación de tareas asíncronas

  AuthenticationClient(this._secureStorage, this._authenticationAPI); // Constructor que recibe el almacenamiento seguro y la API de autenticación

  void _complete() { // Método privado para completar la tarea asíncrona
    if (_completer != null && !_completer.isCompleted) { // Verificar que el completador no esté completado
      _completer.complete(); // Completar el completador
    }
  }

  Future<String?> get accessToken async { // Método para obtener el token de acceso
    if (_completer != null) { // Verificar si hay una tarea asíncrona en curso
      await _completer.future; // Esperar a que la tarea asíncrona actual se complete
    }

    _completer = Completer(); // Reiniciar el completador para una nueva tarea
    final data = await _secureStorage.read(key: 'SESSION'); // Leer los datos de sesión desde el almacenamiento seguro
    if (data != null) { // Verificar si se encontraron datos de sesión
      final session = Session.fromJson(jsonDecode(data)); // Decodificar los datos de sesión en un objeto Session
      final DateTime currentDate = DateTime.now(); // Obtener la fecha y hora actual
      final DateTime createdAt = session.createdAt; // Obtener la fecha y hora de creación de la sesión
      final int expiresIn = session.expiresIn; // Obtener la duración de validez del token
      final int diff = currentDate.difference(createdAt).inSeconds; // Calcular la diferencia en segundos desde la creación de la sesión

      if (expiresIn - diff >= 60) { // Verificar si el token aún es válido (al menos 60 segundos restantes)
        _complete(); // Completar la tarea asíncrona
        return session.token; // Devolver el token de acceso
      }

      final response = await _authenticationAPI.refreshToken(session.token); // Solicitar la actualización del token de acceso
      if (response.data != null) { // Verificar si se obtuvo una respuesta válida
        await this.saveSession(response.data); // Guardar la nueva sesión actualizada
        _complete(); // Completar la tarea asíncrona
        return response.data.token; // Devolver el nuevo token de acceso
      }
      _complete(); // Completar la tarea asíncrona sin éxito

      return null; // Devolver null en caso de error
    }
    _complete(); // Completar la tarea asíncrona sin éxito
    return null; // Devolver null si no se encontraron datos de sesión
  }

  Future<void> saveSession(AuthenticationResponse authenticationResponse) async { // Método para guardar la sesión
    final Session session = Session( // Crear un objeto Session con los datos de autenticación
      token: authenticationResponse.token,
      expiresIn: authenticationResponse.expiresIn,
      createdAt: DateTime.now(),
    );

    final data = jsonEncode(session.toJson()); // Codificar la sesión en formato JSON
    await _secureStorage.write(key: 'SESSION', value: data); // Escribir los datos de sesión en el almacenamiento seguro
  }

  Future<void> signOut() async { // Método para cerrar sesión
    await _secureStorage.deleteAll(); // Borrar todos los datos del almacenamiento seguro (cerrar sesión)
  }
}
