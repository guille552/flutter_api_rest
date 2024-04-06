import 'package:dio/dio.dart'; 
import 'package:flutter_api_rest/api/account_api.dart'; 
import 'package:flutter_api_rest/api/authentication_api.dart'; 
import 'package:flutter_api_rest/data/authentication_client.dart'; 
import 'package:flutter_api_rest/helpers/http.dart'; 
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 
import 'package:get_it/get_it.dart'; 

abstract class DependencyInjection {
  static void initialize() { // Método estático para inicializar la inyección de dependencias
    final Dio dio = Dio( // Crear una instancia de Dio para realizar solicitudes HTTP
      BaseOptions(baseUrl: 'http://127.0.0.1:9000'), // Establecer la URL base para las solicitudes
    );

    Http http = Http( // Crear una instancia de la clase Http para manejar solicitudes HTTP
      dio: dio, // Pasar la instancia de Dio al constructor de Http
      logsEnabled: true, // Habilitar registros de logs para depuración
    );

    final FlutterSecureStorage secureStorage = FlutterSecureStorage(); // Crear una instancia de almacenamiento seguro para datos sensibles

    final authenticationAPI = AuthenticationAPI(http); // Crear una instancia de la API de autenticación
    final authenticationClient = AuthenticationClient(secureStorage, authenticationAPI); // Crear una instancia del cliente de autenticación
    final accountAPI = AccountAPI(http, authenticationClient); // Crear una instancia de la API de cuentas

    GetIt.instance.registerSingleton<AuthenticationAPI>(authenticationAPI); // Registrar la instancia de la API de autenticación como un singleton en GetIt
    GetIt.instance.registerSingleton<AuthenticationClient>(authenticationClient); // Registrar el cliente de autenticación como un singleton en GetIt
    GetIt.instance.registerSingleton<AccountAPI>(accountAPI); // Registrar la API de cuentas como un singleton en GetIt
  }
}
