import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {
  final double size; // Tamaño del contenedor de icono
  const IconContainer({super.key, required this.size})
      : assert(size > 0); // Verifica que el tamaño sea mayor que 0

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, // Ancho del contenedor
      height: size, // Alto del contenedor
      decoration: BoxDecoration(
        color: Colors.white, // Color de fondo del contenedor
        borderRadius: BorderRadius.circular(size * .15), // Bordes redondeados del contenedor
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // Color de la sombra
            blurRadius: 10, // Radio de desenfoque de la sombra
            offset: Offset(0, 15), // Desplazamiento de la sombra en el eje Y
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15), // Espaciado interno del contenedor
      child: Center(
        child: SvgPicture.asset(
          'assets/hoguera.svg', // Ruta del archivo SVG
          width: size, // Ancho del icono SVG
          height: size, // Alto del icono SVG
        ),
      ),
    );
  }
}
