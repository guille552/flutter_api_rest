import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Clase estática para mostrar alertas
abstract class Dialogs {
  static alert(BuildContext context, {
    required String title, // Título de la alerta
    required String description, // Descripción de la alerta
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title), // Título de la alerta
        content: Text(description), // Contenido de la alerta
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(_); // Cerrar la alerta al presionar el botón OK
            },
            child: Text("OK"), // Texto del botón OK
          )
        ],
      ),
    );
  }
}

// Clase estática para mostrar un diálogo de progreso
abstract class ProgressDialog {
  // Método estático para mostrar el diálogo de progreso
  static show(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return WillPopScope(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.9), // Fondo semitransparente
            child: Center(
              child: CircularProgressIndicator(), // Indicador de progreso
            ),
          ),
          // Impedir que se cierre el diálogo al presionar el botón de retroceso
          onWillPop: () async => false,
        );
      },
    );
  }

  // Método estático para cerrar el diálogo de progreso
  static dissmiss(BuildContext context) {
    Navigator.pop(context); // Cerrar el diálogo de progreso
  }
}
