import 'package:flutter/material.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key}); // Constructor de la página de inicio

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>(); // Cliente de autenticación

  @override
  void initState() {
    super.initState();

    // Callback para verificar el inicio de sesión después de que se renderiza la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLogin(); // Función para verificar el inicio de sesión
    });
  }

  Future<void> _checkLogin() async {
    final token = await _authenticationClient.accessToken; // Obtener el token de acceso
    if (token == null) {
      Navigator.pushReplacementNamed(context, LoginPage.routeName); // Redireccionar a la página de inicio de sesión si no hay token
      return;
    }
    Navigator.pushReplacementNamed(context, HomePage.routeName); // Redireccionar a la página de inicio si hay token
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Indicador de carga mientras se verifica el inicio de sesión
      ),
    );
  }
}
