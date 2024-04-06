class HttpResponse {
  final dynamic data; // Datos de la respuesta
  final HttpError error; // Error de la respuesta

  HttpResponse(this.data, this.error); // Constructor para inicializar los datos y el error de la respuesta

  HttpResponse.success(dynamic data) // Constructor para una respuesta exitosa
      : data = data, // Inicializar los datos con la información recibida
        error = HttpError( // Inicializar el error con un estado de éxito
          statusCode: 200, // Estado HTTP 200 (éxito)
          message: 'Success', // Mensaje de éxito
          data: null, // Sin datos adicionales en caso de éxito
        );

  HttpResponse.fail({ // Constructor para una respuesta fallida
    required dynamic data, // Datos de la respuesta fallida
    required int statusCode, // Estado HTTP de la respuesta fallida
    required String message, // Mensaje de error de la respuesta fallida
  })  : data = data, // Inicializar los datos con la información recibida
        error = HttpError( // Inicializar el error con los detalles de la respuesta fallida
          statusCode: statusCode, // Estado HTTP de la respuesta fallida
          message: message, // Mensaje de error de la respuesta fallida
          data: data, // Datos adicionales de la respuesta fallida
        );
}

class HttpError {
  final int statusCode; // Estado HTTP del error
  final String message; // Mensaje de error
  final dynamic data; // Datos adicionales del error

  HttpError({
    required this.statusCode, // Estado HTTP del error
    required this.message, // Mensaje de error
    required this.data, // Datos adicionales del error
  });
}
