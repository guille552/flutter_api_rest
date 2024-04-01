//import 'dart:html';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_api_rest/helpers/http_response.dart';
import 'package:logger/logger.dart';
//import 'package:meta/meta.dart' show required;

class AuthenticationAPI {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

//-----------El método register es una función asíncrona (async) que requiere tres 
//parámetros para funcionar correctamente: username, email y password. 
//Estos parámetros son marcados como obligatorios usando la palabra clave required, 
//lo que significa que deben ser proporcionados cuando se llama al método register.

  Future<HttpResponse> register({
    required String username,
    required String email,
    required String password,
  }) async{
    try{
      final response = await _dio.post(
        'http://10.0.2.2:9000/api/v1/register', 
        data:{
          "username":username,
          "email":email,
          "password":password,
        },
      );
    //---La respuesta se guarda en una variable y se registra 
    //utilizando el método i de Logger. Si ocurre algún error 
    //durante la solicitud, se captura en un bloque catch y 
    //se registra utilizando el método e de Logger.----------
    _logger.i(response.data);
    return HttpResponse.success(response.data);
    } catch(e){
       _logger.e(e);

      int? statusCode = -1;
      String? message = "unknown error";
      dynamic data;
      
      if(e is DioError){
        message = e.message;
        if (e.response != null){
          statusCode = e.response?.statusCode;
          message = e.response?.statusMessage;
          data = e.response?.data;
        }
      }

      return HttpResponse.fail(
      statusCode: statusCode!, 
      message: message!, 
      data: data,
      );
    }
  }

  Future<HttpResponse> login({
    required String email,
    required String password,
  }) async{
    try{
      await Future.delayed(Duration(seconds: 2));
      final Response response = await _dio.post(
        'http://10.0.2.2:9000/api/v1/login',
        data:{
          "email":email,
          "password":password,
        },
      );
    //---La respuesta se guarda en una variable y se registra 
    //utilizando el método i de Logger. Si ocurre algún error 
    //durante la solicitud, se captura en un bloque catch y 
    //se registra utilizando el método e de Logger.----------
    _logger.i(response.data);
    return HttpResponse.success(response.data);
    } catch(e){
       _logger.e(e);

      int? statusCode = -1;
      String? message = "unknown error";
      dynamic data;
      
      if(e is DioError){
        message = e.message;
        if (e.response != null){
          statusCode = e.response?.statusCode;
          message = e.response?.statusMessage;
          data = e.response?.data;
        }
      }

      return HttpResponse.fail(
      statusCode: statusCode!, 
      message: message!, 
      data: data,
      );
    }
  }
}