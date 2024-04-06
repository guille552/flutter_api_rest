import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/icon_container.dart';
import 'package:flutter_api_rest/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login'; // Nombre de la ruta de la página de inicio de sesión

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context); // Objeto para hacer la interfaz responsive

    // Tamaños responsivos para las esferas roja y azul
    final double redSize = responsive.wp(80);
    final double blueSize = responsive.wp(57);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Quitar el foco al tocar fuera de un elemento enfocado
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // Esfera roja grande en la parte superior derecha
                Positioned(
                  top: -redSize * 0.4,
                  right: -redSize * 0.2,
                  child: Circle(
                    size: redSize,
                    colors: [
                      const Color.fromARGB(255, 255, 17, 0),
                      Color.fromARGB(255, 99, 0, 0),
                    ],
                  ),
                ),
                // Esfera azul pequeña en la parte superior izquierda
                Positioned(
                  top: -blueSize * 0.55,
                  left: -blueSize * 0.15,
                  child: Circle(
                    size: blueSize,
                    colors: [
                      Color.fromARGB(255, 113, 0, 148),
                      Color.fromARGB(255, 45, 1, 116),
                    ],
                  ),
                ),
                // Icono y texto debajo
                Positioned(
                  top: redSize * 0.35,
                  child: Column(
                    children: <Widget>[
                      IconContainer(
                        size: responsive.wp(17), // Tamaño responsivo del icono
                      ),
                      SizedBox(
                        height: responsive.dp(3), // Espacio entre el icono y el texto
                      ),
                      Text(
                        "hello!!!\nSign Up to get started", // Texto debajo del icono
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.6), // Tamaño de fuente responsivo
                        ),
                      )
                    ],
                  ),
                ),
                LoginForm(), // Formulario de inicio de sesión
              ],
            ),
          ),
        ),
      ),
    );
  }
}
