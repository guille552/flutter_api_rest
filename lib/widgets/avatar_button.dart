import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarButton extends StatelessWidget {
  final double imageSize; // Tamaño del avatar
  const AvatarButton({
    super.key,
    this.imageSize = 100, // Valor por defecto para el tamaño del avatar
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Contenedor del avatar con decoración y sombra
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black26,
                offset: Offset(0, 20),
              ),
            ],
          ),
          // Avatar como imagen redondeada
          child: ClipOval(
            child: Image.network(
              // URL de la imagen del avatar
              'https://static.wikia.nocookie.net/overwatch_gamepedia/images/9/97/PI_Cassidy_Silhouette.png/revision/latest?cb=20240228084914',
              width: imageSize, // Ancho del avatar
              height: imageSize, // Alto del avatar
            ),
          ),
        ),
        // Botón de añadir en la esquina inferior derecha del avatar
        Positioned(
          bottom: 5, // Distancia desde la parte inferior
          right: 0, // Distancia desde la parte derecha
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(30), // Bordes redondeados del botón
            child: Container(
              child: Icon(
                Icons.add, // Icono de añadir
                color: Colors.white, // Color del icono
              ),
              padding: EdgeInsets.all(3), // Espaciado interno del contenedor del icono
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2), // Borde blanco alrededor del contenedor
                color: Color.fromARGB(255, 99, 0, 0), // Color de fondo del contenedor
                shape: BoxShape.circle, // Forma circular del contenedor
              ),
            ),
            onPressed: () {}, // Función que se ejecutará al presionar el botón
          ),
        )
      ],
    );
  }
}
