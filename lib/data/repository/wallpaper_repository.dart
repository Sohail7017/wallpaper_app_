
import 'package:wallpaper_app/data/remote/api_helper.dart';
import 'package:wallpaper_app/data/remote/urls.dart';

class WallpaperRepository{
  ApiHelper apiHelper;
  WallpaperRepository({required this.apiHelper});


  /// Search Wallpapers

  Future<dynamic> getSearchWallpapers(String mQuery) async{
    try {
      return await apiHelper.getWallpaperApi(url: "${Urls.SEARCH_Wall_URL}?query= $mQuery");

    } catch(e){
      throw(e);
    }
  }


  /// Trending Wallpapers
  Future<dynamic> getTrendingWallpapers() async{
    try {
      return await apiHelper.getWallpaperApi(url: Urls.TRENDING_WALL_URL);

    } catch(e){
      throw(e);
    }
    }
}