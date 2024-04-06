import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:get_it/get_it.dart';
import 'input_text.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _authenticationAPI = GetIt.instance<AuthenticationAPI>(); // Instancia de la API de autenticación
  final _authenticationClient = GetIt.instance<AuthenticationClient>(); // Cliente de autenticación

  GlobalKey<FormState> _formKey = GlobalKey(); // Clave global para el formulario
  String _email = '', _password = ''; // Variables para almacenar el correo electrónico y la contraseña

  Future<void> _submit() async {
    final isOk = _formKey.currentState!.validate(); // Validar el formulario

    if (isOk) {
      ProgressDialog.show(context); // Mostrar diálogo de progreso

      final response = await _authenticationAPI.login( // Iniciar sesión con la API de autenticación
        email: _email,
        password: _password,
      );
      ProgressDialog.dissmiss(context); // Ocultar diálogo de progreso
      if (response.data != null) { // Si la respuesta es exitosa
        await _authenticationClient.saveSession(response.data); // Guardar sesión de usuario
        Navigator.pushNamedAndRemoveUntil( // Navegar a la página de inicio y eliminar las rutas anteriores
          context,
          HomePage.routeName,
          (_) => false,
        );
      } else { // Si hay un error en la respuesta
        String message = response.error.message; // Obtener el mensaje de error
        if (response.error.statusCode == -1) {
          message = "Bad network";
        } else if (response.error.statusCode == 403) {
          message = "Invalid password";
        } else if (response.error.statusCode == 404) {
          message = "User not found";
        }

        Dialogs.alert( // Mostrar un diálogo de alerta con el mensaje de error
          context,
          title: "ERROR",
          description: message,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context); // Obtener el objeto Responsive para el diseño responsivo

    return Positioned( // Posicionar el formulario en la parte inferior de la pantalla
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 360, // Establecer el ancho máximo según el tipo de dispositivo
        ),
        child: Form( // Crear un formulario con una clave global
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputText( // Campo de entrada para el correo electrónico
                keyboardType: TextInputType.emailAddress,
                label: "EMAIL ADDRESS",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _email = text; // Actualizar el valor del correo electrónico
                },
                validator: (text){ // Validador personalizado para el correo electrónico
                  if (text != null && !text.contains("@")) {
                    return "invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              Container( // Contenedor para la contraseña
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InputText( // Campo de entrada para la contraseña
                        label: "PASSWORD",
                        obscureText: true,
                        borderEnabled: false,
                        fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                        onChanged: (text) {
                          _password = text; // Actualizar el valor de la contraseña
                        },
                        validator: (value) { // Validador personalizado para la contraseña
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio.';
                          } 
                          else if (value.trim().length < 5) {
                            return 'Ingresa al menos 5 caracteres válidos.';
                          }
                          return null; 
                        },
                      ),
                    ),
                    CupertinoButton( // Botón para recuperar contraseña (sin funcionalidad en este código)
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              SizedBox(height: responsive.dp(5)),
              SizedBox( // Botón para enviar el formulario
                width: double.infinity,
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  onPressed: _submit,
                  color: const Color.fromARGB(255, 109, 108, 108),
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              Row( // Texto y botón para registrarse como nuevo usuario
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "New to Friendly Desi?",
                    style: TextStyle(
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                  CupertinoButton(
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Color.fromARGB(255, 76, 0, 138),
                        fontSize: responsive.dp(1.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'register'); // Navegar a la pantalla de registro
                    },
                  )
                ],
              ),
              SizedBox(height: responsive.dp(10)), // Espacio adicional al final del formulario
            ],
          ),
        ),
      ),
    );
  }
}
