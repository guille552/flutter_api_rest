import 'package:dio/dio.dart'; 
import 'package:flutter_api_rest/helpers/http_response.dart'; 
import 'package:flutter_api_rest/utils/logs.dart'; 

class Http {
  // Instancia de la clase Dio para realizar solicitudes HTTP
  late Dio _dio; 
  // Variable para habilitar o deshabilitar los registros/logs
  late bool _logsEnabled; 

  Http({
    // Parámetro requerido para la instancia de Dio
    required Dio dio, 
    // Parámetro requerido para habilitar o deshabilitar los registros/logs
    required bool logsEnabled, 
  }) {
    // Asignación de la instancia de Dio recibida al atributo _dio
    _dio = dio; 
    // Asignación del valor de logsEnabled al atributo _logsEnabled
    _logsEnabled = logsEnabled; 
  }

  // Método para realizar una solicitud HTTP genérica
  Future<HttpResponse> request<T>(
    String path, {
      // Método HTTP por defecto (GET)
    String method = "GET", 
    // Parámetros de consulta de la solicitud
    required Map<String, dynamic> queryParameters, 
    // Datos de la solicitud
    required Map<String, dynamic> data, 
    // Datos de formulario de la solicitud
    required Map<String, dynamic> formData, 
    // Encabezados de la solicitud
    required Map<String, String> headers, 
    // Función de análisis para convertir los datos de la respuesta
    required T Function(dynamic data) parser, 
  }) async {
    try {
      // Inicialización de FormData (no se usa en este código)
      FormData formData = FormData.fromMap({}); 

      // Realizar la solicitud HTTP usando la instancia de Dio (_dio)
      final response = await _dio.request(
        path,
        options: Options(
          method: method,
          headers: headers,
        ),
        // Selección de los datos a enviar en la solicitud
        queryParameters: queryParameters,
        data: formData != null ? FormData.fromMap(formData as Map<String, dynamic>) : data, 
      );

      // Registrar la respuesta en los registros/logs
      Logs.p.i(response.data); 

      if (parser != null) {
        // Devolver una HttpResponse con los datos analizados correctamente
        return HttpResponse.success(parser(response.data)); 
      }
      // Devolver una HttpResponse con los datos de la respuesta sin analizar
      return HttpResponse.success(response.data); 
    } catch (e) {
      // Registrar el error en los registros/logs

      Logs.p.e(e); 
      int statusCode = 0; // Código de estado por defecto (0)
      String message = "unknown error"; // Mensaje de error por defecto ("unknown error")
      dynamic data; // Datos del error

      if (e is DioError) {
        statusCode = -1; // Código de estado para errores de DioError (-1)
        message = e.message!; // Obtener el mensaje de error del objeto DioError
        if (e.response != null) {
          statusCode = e.response!.statusCode!; // Obtener el código de estado de la respuesta
          message = e.response!.statusMessage!; // Obtener el mensaje de estado de la respuesta
          data = e.response?.data; // Obtener los datos de la respuesta
        }
      }

      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
