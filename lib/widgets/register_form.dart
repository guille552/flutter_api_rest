import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';

//----------esta parte del código define un widget LoginForm que puede mantener 
//un estado mutable a través de su clase de estado _LoginFormState, permitiendo 
//cambios dinámicos en la interfaz de usuario según la interacción del usuario.

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
//lo que hace esta parte es la validacion de datos de los formularios 
GlobalKey<FormState> _formKey = GlobalKey();
String _email = '', _password = '', _username = '';
final AuthenticationAPI _authenticationAPI =AuthenticationAPI();

_submit(){
  final form = _formKey.currentState;
  if (form != null) {
    final isOk = form.validate();
    print("form isOk $isOk");
    if (isOk) {
      _authenticationAPI.register(username: _username, email: _email, password: _password);
    }
  }
}
  @override
//------------Dentro del método build, se utiliza el widget Positioned 
//para posicionar el contenido dentro del árbol de widgets de Flutter. 
//Se especifica que el widget se coloque en la parte inferior de la 
//pantalla con un margen izquierdo y derecho.-------------------------
  Widget build(BuildContext context) {

final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430:360,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
          //crea una columna con dos campos de entrada de texto. 
          //El primero es para correos electrónicos, 
          //mientras que el segundo es para contraseñas y 
          //oculta el texto ingresado.---------------------------
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "USERNAME",
                fontSize: responsive.dp(responsive.isTablet ? 1.2:1.4),
                onChanged: (text){
                  _username = text;
                },
                  //-----esta parte de aqui es un validador en donde especifica que
                  //si el texto introducido es nulo o que no tiene el arroba
                  //marcara el error de invalid email, pero si tiene el arroba
                  //este validara el campo por lo que pasara al siguiente validador
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
              SizedBox(height: responsive.dp(2),),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "EMAIL ADDRESS",
                fontSize: responsive.dp(responsive.isTablet ? 1.2:1.4),
                onChanged: (text){
                  _email = text;
                  },
                  //-----esta parte de aqui es un validador en donde especifica que
                  //si el texto introducido es nulo o que no tiene el arroba
                  //marcara el error de invalid email, pero si tiene el arroba
                  //este validara el campo por lo que pasara al siguiente validador
                  validator: (text){
                    if (text != null && !text.contains("@")) {
                      return "invalid email";
                    }
                    return null;
                  },
              ),
              SizedBox(height: responsive.dp(2),),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "PASSWORD",
                fontSize: responsive.dp(responsive.isTablet ? 1.2:1.4),
                onChanged: (text){
                  _password = text;
                },
                  //-----esta parte de aqui es un validador en donde especifica que
                  //si el texto introducido es nulo o que no tiene el arroba
                  //marcara el error de invalid email, pero si tiene el arroba
                  //este validara el campo por lo que pasara al siguiente validador
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
              SizedBox(height: responsive.dp(5),),
              //esta seccion de codigo lo que hace es que crea el boton de Sign In 
              //asi como tambien se le da formato de tamaño y estilo -------------
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: responsive.dp(1.6),
                    ),
                  ),
                  onPressed: this._submit,
                  color: Color.fromARGB(255, 121, 121, 121),
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              //en esta seccion se crea la fila para el registro en donde esta
              //el texto y el boton-------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: responsive.dp(1.6),
                    ),
                  ),
                  //en esta parte se encuentra ubicdo el boton Sign Up con su respectivo
                  //estilo--------------------------------------------------------------
                  MaterialButton(
                    child: Text(
                      "Sign In", 
                      style: TextStyle(color: Colors.deepPurpleAccent,
                        fontSize: responsive.dp(1.6),
                      ),
                    ),
                    onPressed: () {
                     Navigator.pop(context);
                    },
                  ),
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