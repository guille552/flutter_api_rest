import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart' show required;

class AuthenticationAPI {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<void>  register({
    required String username,
    required String email,
    required String password,
  }) async{
      final Response response = await _dio.post(
        'http://10.0.2.2:9000/api/v1/login', 
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data:{
        "username":username,
        "email":email,
        "password":password,
      },
    );
    _logger.i(response.data);
  }
}