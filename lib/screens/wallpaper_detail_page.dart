import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:wallpaper_app/api_utility/util_helper.dart';
import 'package:wallpaper_app/models/trending_wallpaper_model.dart';

class WallpaperDetailPage extends StatelessWidget {
  Src imageModel;
  
   WallpaperDetailPage({required this.imageModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(imageModel.portrait!,fit: BoxFit.cover,)),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    actionButton(onTap: (){}, title: "info", icon: Icons.info_outline),
                    SizedBox(
                      width: 35,
                    ),
                
                    actionButton(onTap: (){saveWallpaper(context);}, title: "Save", icon: Icons.save_alt_outlined),
                
                    SizedBox(
                      width: 35,
                    ),
                    actionButton(onTap: (){applyWallpaper(context);}, title: "Apply", icon: Icons.brush_sharp,bgColor: AppColor.blueColor),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget actionButton({
    required VoidCallback onTap,
    required String title,
    required IconData icon,
    Color? bgColor,
  } ){
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
                color: bgColor!= null ? AppColor.blueColor : Colors.white.withOpacity(0.3),
            ),
            child: Icon(icon,color: Colors.white,size: 30,),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(title,style: mTextStyle16(mColor: Colors.white,mFontWeight: FontWeight.bold),),
        
      ],
    );
  }


  void saveWallpaper(BuildContext context){
    GallerySaver.saveImage(imageModel.portrait!).then((value) =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Saved Successfully!!'))));
  }


  void applyWallpaper(BuildContext context){
    Wallpaper.imageDownloadProgress(imageModel.portrait!).listen((event) {

    },
    onDone: (){
      Wallpaper.homeScreen(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        options: RequestSizeOptions.resizeFit
      ).then((value) {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Wallpaper set on Home Screen!!")));
      });
    },
      onError: (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Download Error: $e, Error while Setting the wallpaper")));
      }

    );
  }


}
