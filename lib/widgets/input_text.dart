import 'package:flutter/material.dart';

//--------------La clase InputText en Flutter se utiliza
// para crear un campo de entrada de texto con opciones 
//como etiqueta, tipo de teclado y la capacidad de ocultar
// el texto ingresado. Esto permite diseñar formularios
// con funcionalidades específicas, como campos de contraseña 
//o información confidencial.--------------------------------

class InputText extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool obscureText, borderEnabled;
  final double fontSize;
  final void Function(String) onChanged;
  final String? Function(String? text)? validator;
  const InputText({
    Key? key, 
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false, 
    this.borderEnabled = true,
    this.fontSize = 15, 
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override

//---------------------El método build en InputText crea un campo 
//de texto interactivo usando TextFormField en Flutter. Configura el 
//teclado, la visibilidad del texto y la apariencia del campo, 
//incluida la etiqueta.----------------------------------------

  Widget build(BuildContext context) {
    return TextFormField(
//----------keyboardType: keyboardType define el tipo de teclado 
//(numérico, texto, etc.), mientras que obscureText: obscureText 
//oculta el texto (por ejemplo, para contraseñas).--------------
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
//------------------Esto configura el aspecto visual del campo de entrada de texto, 
//incluyendo la etiqueta que se muestra encima del campo. La etiqueta (labelText)
// se establece como el valor de this.label, y se define un estilo para la etiqueta 
//con un color específico y un tamaño de fuente.-----------------------------------
      style: TextStyle(
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(vertical: 5),
        enabledBorder:borderEnabled
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black12,
                )
              )
            : InputBorder.none,
        labelStyle: TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
