import 'package:flutter/material.dart';
import 'dart:math' as math;

//Este código define una clase llamada Responsive que 
//ayuda a calcular dimensiones proporcionales--------

class Responsive {
 late double _width, _height, _diagonal;
 late bool _isTablet;

//Define métodos para obtener el ancho, alto y diagonal de la pantalla.

double get width => _width;
double get height => _height;
double get diagonal => _diagonal;
bool get isTablet => _isTablet;

static Responsive of(BuildContext context) => Responsive(context);
  Responsive(BuildContext context){
  final Size size = MediaQuery.of(context).size;
  _width = size.width;
  _height = size.height;
  

  //c2+a2+b2 => c = srt(a2+b2)
  //calcula la longitud de la diagonal de la pantalla utilizando el teorema de Pitágoras.
  _diagonal =math.sqrt(math.pow(_width, 2)+ math.pow(_height, 2));

  _isTablet = size.shortestSide >=600;
  }
//----------Métodos que permiten calcular dimensiones proporcionales 
//basadas en un porcentaje del ancho, alto o diagonal de la pantalla.
  double wp(double percent) => _width* percent /100;
  double hp(double percent) => _height* percent /100;
  double dp(double percent) => _diagonal* percent /100;
}
