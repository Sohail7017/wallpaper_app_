import 'package:wallpaper_app/models/trending_wallpaper_model.dart';

abstract class SearchWallpaperState{}

class SearchInitialState extends SearchWallpaperState{}
class SearchLoadingState extends SearchWallpaperState{}
class SearchLoadedState extends SearchWallpaperState{
  List<Photos> listPhotos;
  num totalWallpapers;
  SearchLoadedState({required this.listPhotos, required this.totalWallpapers});

}
class SearchErrorState extends SearchWallpaperState{
  String? errMsg;
  SearchErrorState({required this.errMsg});

}