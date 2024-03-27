import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {
    final double size;
  // ignore: unnecessary_null_comparison
  const IconContainer({super.key, required this.size}):assert(Size!=null && size>0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size*.15),
        boxShadow:[ 
          BoxShadow( color: Colors.black12, 
          blurRadius: 10,
          //spreadRadius: 15,
          offset: Offset(0, 15),
          ),
        ],
      ), 
      padding: EdgeInsets.all(size*.15),
      child: Center(
        child: SvgPicture.asset('assets/hoguera.svg',
        width: size,
        height: size,
        ),
      ),
    );
  }
}