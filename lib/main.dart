import 'package:flutter/material.dart';
import 'package:flutter_api_rest/helpers/dependency_injection.dart'; 
import 'package:flutter_api_rest/pages/home_page.dart'; 
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter_api_rest/pages/register_page.dart'; 
import 'package:flutter_api_rest/pages/splash_page.dart'; 

void main() {
  DependencyInjection.initialize(); // Inicialización de la inyección de dependencias
  runApp(const MainApp()); // Ejecución de la aplicación principal
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([ // Configuración de las orientaciones preferidas
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      home: SplashPage(), // Página de inicio: página de inicio rápido
      routes: { // Definición de rutas para navegación
        RegisterPage.routeName: (_) => RegisterPage(), // Ruta para la página de registro
        LoginPage.routeName: (_) => LoginPage(), // Ruta para la página de inicio de sesión
        HomePage.routeName: (_) => HomePage(), // Ruta para la página de inicio
      },
    );
  }
}
