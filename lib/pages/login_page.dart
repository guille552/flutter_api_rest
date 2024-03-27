import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/icon_container.dart';
import 'package:flutter_api_rest/widgets/login_form.dart';

//---------------------------Se elige un StatefulWidget para la pantalla de inicio (HomePage) porque 
//proporciona la flexibilidad necesaria para manejar responsividad, interactividad y 
//actualizaciones de estado que son comunes en las interfaces de usuario de las aplicaciones móviles.

class LoginPage extends StatefulWidget {
  static const routeName ='login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
   final Responsive responsive = Responsive.of(context);
   //--------------en esta parte se crean las medidas para que sea responsivo en donde 
   //redsize es para darle la medida a la esfera roja, es decir a la mas grande
   // y bluesize es para darle la medida a la esfera azul es decir a la mas pequeña---
   final double redsize = responsive.wp(80);
   final double bluesize = responsive.wp(57);


//Esta parte del código sirve para crear la estructura básica de la pantalla de inicio
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              //-------------toda esta seccion sirve para darle un estilo 
              //al circulo mas grande y tambien las medidas son responsivas
              //debido a que en diferentes dispositivos se ve de una manera
              //no tan agradable a la vista--------------------------------
              children: <Widget>[
                Positioned(
                  top: -redsize*0.4,
                  right:-redsize*0.2,
                  child: Circle(
                    size: redsize,
                    colors: [
                      const Color.fromARGB(255, 255, 17, 0),
                      Color.fromARGB(255, 99, 0, 0),
                    ],
                  ),
                ),
                //en esta parte del codigo se crea el circulo mas pequeño que tendra una degradacion
                //de color de un azul a un morado, casi indistiguible, tambien se le asigna las medidas
                //responsivas para que con este no se desfase de una manera no tan agradable-----------
                Positioned(
                  top: -bluesize*0.55,
                  left: -bluesize*0.15,
                  child: Circle(
                    size: bluesize,
                    colors: [
                      Color.fromARGB(255, 113, 0, 148),
                      Color.fromARGB(255, 45, 1, 116),
                    ],
                  ),
                ),
  //lo que hace esta parte es crear un contenedor en donde se encontrara ubicado el texto que se
  //muestra abajo del icono en el cual se aplica las medidas responsivas para que este se ajuste 
  //al tamaño de la pantalla y asi hacer que se vea de manera identica en todas las pantallas---
                Positioned(
                  top: redsize*0.35,
                  child: Column(
                    children:<Widget> [
                      IconContainer(
                        size: responsive.wp(17),
                      ),
                      SizedBox(
                        height: responsive.dp(3),
                      ),
  //aqui es donde se coloca el texto que se ubica debajo del icono asi como tambien se le aplica
  //una medida responsiva respecto a la medida de la pantalla-----------------------------------
                      Text(
                        "hello!!!\nSign Up to get started",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.dp(1.6),
                        ),
                      )
                    ],
                  ),
                ),
                LoginForm(),
              ],
            ),
          ),
        )
      ),
    );
  }
}