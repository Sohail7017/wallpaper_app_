import 'package:wallpaper_app/models/trending_wallpaper_model.dart';

abstract class WallpaperState{}

class WallpaperInitialState extends WallpaperState{}
class WallpaperLoadingState extends WallpaperState{}
class WallpaperLoadedState extends WallpaperState{
  List<Photos> listPhotos;
  WallpaperLoadedState({required this.listPhotos});

}
class WallpaperErrorState extends WallpaperState{
  String? errMsg;
  WallpaperErrorState({required this.errMsg});

}