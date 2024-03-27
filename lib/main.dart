import 'package:flutter/material.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_rest/pages/register_page.dart';
import 'package:flutter_api_rest/widgets/login_form.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //------------esta parte sirve para evitar que la aplicacion ajuste
    //su tamaño a la forma del dispositivo cuando este cambia de posicion
    //esto sirve para dispositivos moviles tales como telefonos y tablets
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      home: LoginPage(),
      routes: {
        RegisterPage.routeName: (_) => RegisterPage(),
        LoginPage.routeName: (_) => LoginPage(),
        
      },
    );
  }
}
