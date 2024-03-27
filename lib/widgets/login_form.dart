import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';

//----------esta parte del código define un widget LoginForm que puede mantener 
//un estado mutable a través de su clase de estado _LoginFormState, permitiendo 
//cambios dinámicos en la interfaz de usuario según la interacción del usuario.

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
//lo que hace esta parte es la validacion de datos de los formularios 
GlobalKey<FormState> _formKey = GlobalKey();

_submit(){
  final form = _formKey.currentState;
  if (form != null) {
    final isOk = form.validate();
    print("form isOk $isOk");
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
                label: "EMAIL ADDRESS",
                fontSize: responsive.dp(responsive.isTablet ? 1.2:1.4),
                onChanged: (text){
                  print("email: $text",);
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
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                //en esta parte se crea una fila para poder agregar el boton
                //"forgot password" debido a que es la unica forma en la que 
                //se puede perfilar dos widgets en una sola linea.----------
                child: Row(
                  children: <Widget> [
                    Expanded(
                      child: InputText(
                        label: "PASSWORD",
                        obscureText: true,
                        borderEnabled: false,
                        fontSize: responsive.dp(responsive.isTablet ? 1.2:1.4),
                        onChanged: (text){
                          print("password: $text");
                        },
                        //aqui se encuentra el validador de la contraseña en donde
                        //valida que sean caracteres validos y no solo espacios
                        //vacios en donde si ocurre esto, no lo contara y solo 
                        //contara los caracteres validos, si no mostrara el mensaje
                        //"invalid password"
                        validator: (text){
                          if (text?.trim().isEmpty ?? true) {
                            return "invalid password";
                          }
                        return null;
                        },
                      ),
                    ),
                    //-------en esta parte se crea el boton "forgot password" y se le
                    //agrega estilos, asi como tambien se le da el formato responsivo
                    //para que se pueda adaptar a los diferentes tamaños de pantalla-
                    MaterialButton(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Forgot Password', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.dp(responsive.isTablet ? 1.2:1.5),
                        ),
                      ),
                    onPressed: (){},
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsive.dp(5),),
              //esta seccion de codigo lo que hace es que crea el boton de Sign In 
              //asi como tambien se le da formato de tamaño y estilo -------------
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Sign In',
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
                    "New to Friend Desi?",
                    style: TextStyle(
                      fontSize: responsive.dp(1.6),
                    ),
                  ),
                  //en esta parte se encuentra ubicdo el boton Sign Up con su respectivo
                  //estilo--------------------------------------------------------------
                  MaterialButton(
                    child: Text(
                      "Sign Up", 
                      style: TextStyle(color: Colors.deepPurpleAccent,
                        fontSize: responsive.dp(1.6),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
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