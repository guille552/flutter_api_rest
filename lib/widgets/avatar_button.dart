import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarButton extends StatelessWidget {
  final double imageSize;
  const AvatarButton({
    super.key, 
    this.imageSize = 100
    });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:<Widget> [
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: (20), 
                color: Colors.black26,
                offset: Offset(0, 20),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              'https://static.wikia.nocookie.net/overwatch_gamepedia/images/9/97/PI_Cassidy_Silhouette.png/revision/latest?cb=20240228084914', 
              width: imageSize,
              height: imageSize,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              child: Icon(Icons.add, 
              color: Colors.white,
              ),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white,
                width: 2),
                color: Color.fromARGB(255, 99, 0, 0),
                shape: BoxShape.circle
              ),
            ),
            onPressed: (){}
          ),
        )
      ],
    );
  }
}