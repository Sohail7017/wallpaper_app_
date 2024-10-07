import 'package:flutter/material.dart';


class WallpaperWidget extends StatelessWidget {
 double mWidth;
 double mHeight;
  String imgUrl;

   WallpaperWidget({
     super.key,
     required this.imgUrl,
    this.mWidth = 180,
     this.mHeight = 240,
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mHeight,
      width: mWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(imgUrl))
      ),
     );
  }
}
