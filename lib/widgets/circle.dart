import 'package:flutter/material.dart';

// se implementa como un StatelessWidget porque su naturaleza inmutable y 
//su función de representar un círculo estático con gradientes de colores no 
//requieren la gestión de un estado interno mutable.------------------------

class Circle extends StatelessWidget {
  final double size;
  final List<Color> colors;

//----------El código del constructor de Circle se encarga de recibir y validar 
//los parámetros necesarios para crear un círculo (tamaño y colores), asegurando 
//que sean válidos para su uso en la interfaz de usuario.-----------------------

  Circle ({Key? key, 
  required this.size, 
  required this.colors
  }) : assert(size !=null && size > 0 ),
     assert(colors !=null && colors.length >= 2 ),
    super(key: key);

//------------esta parte del código crea un círculo visualmente 
//atractivo con un gradiente de colores dentro de un 
//widget Container---------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
      ),
    );
  }
}