import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:get_it/get_it.dart';
import 'input_text.dart';

// La clase RegisterForm es un formulario de registro que permite a los usuarios registrarse en la aplicación.
class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // Se obtienen las instancias necesarias para realizar la autenticación y el manejo de sesiones.
  final _authenticationAPI = GetIt.instance<AuthenticationAPI>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  // Se crea una clave global para el formulario y se inicializan variables para almacenar los datos del usuario.
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '', _username = '';

  // Método para enviar el formulario de registro y validar los datos ingresados por el usuario.
  Future<void> _submit() async {
    final isOk = _formKey.currentState!.validate();

    if (isOk) {
      // Muestra un indicador de progreso mientras se envía el formulario.
      ProgressDialog.show(context);
      
      // Envía la solicitud de registro al servidor API.
      final response = await _authenticationAPI.register(
        username: _username,
        email: _email,
        password: _password,
      );

      // Oculta el indicador de progreso después de obtener la respuesta.
      ProgressDialog.dissmiss(context);

      // Si la respuesta es exitosa, guarda la sesión del usuario y lo redirige a la página de inicio.
      if (response.data != null) {
        await _authenticationClient.saveSession(response.data);
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.routeName,
          (_) => false,
        );
      } else {
        // Si hay un error en la respuesta, muestra un diálogo de alerta con el mensaje de error.
        String message = response.error.message;
        if (response.error.statusCode == -1) {
          message = "Bad network";
        } else if (response.error.statusCode == 409) {
          message = "Duplicated user ${jsonEncode(response.error.data['duplicatedFields'])}";
        }

        Dialogs.alert(
          context,
          title: "ERROR",
          description: message,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 360,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Campo de entrada para el nombre de usuario.
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "USERNAME",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _username = text;
                },
                validator: (text) {
                  if (text!.trim().length < 5) {
                    return "Invalid username";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              // Campo de entrada para el correo electrónico.
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "EMAIL ADDRESS",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _email = text;
                },
                validator: (text){
                  if (text != null && !text.contains("@")) {
                    return "invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              // Campo de entrada para la contraseña.
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "PASSWORD",
                obscureText: true,
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _password = text;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio.';
                  } 
                  else if (value.trim().length < 5) {
                    return 'Ingresa al menos 5 caracteres válidos.';
                  }
                  return null; 
                },
              ),
              SizedBox(height: responsive.dp(5)),
              // Botón para enviar el formulario de registro.
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                  onPressed: this._submit,
                  color: const Color.fromARGB(255, 104, 104, 104),
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              // Enlace para redirigir al usuario a la página de inicio de sesión.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                  CupertinoButton(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Color.fromARGB(255, 76, 0, 138),
                        fontSize: responsive.dp(1.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              SizedBox(height: responsive.dp(10)),
            ],
          ),
        ),
      ),
    );
  }
}
