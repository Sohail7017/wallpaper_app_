import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/api_utility/util_helper.dart';
import 'package:wallpaper_app/screens/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/screens/search/cubit/search_wallpaper_state.dart';
import 'package:wallpaper_app/widgets/wallpaper_widget.dart';

class SearchWallpaperPage extends StatefulWidget {
  String query;
  SearchWallpaperPage({required this.query});

  @override
  State<SearchWallpaperPage> createState() => _SearchWallpaperPageState();
}

class _SearchWallpaperPageState extends State<SearchWallpaperPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchCubit>(context).getSearchWallpapers(query: widget.query);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchCubit,SearchWallpaperState>(
          builder: (_,state){
            if(state is SearchErrorState){
              return Center(child: CircularProgressIndicator(),);
            }else if (state is SearchErrorState){
              return Center(child: Text(state.errMsg.toString()),);
            }else if(state is SearchLoadedState){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(widget.query,style: mTextStyle25(mFontWeight: FontWeight.bold),),
                    Text("${state.totalWallpapers} Wallpapers available",style: mTextStyle16(mFontWeight: FontWeight.bold),),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 3/4
                            ),
                            itemCount: state.listPhotos.length,
                            itemBuilder: (_,index){
                              var eachPhoto = state.listPhotos[index];
                              return WallpaperWidget(imgUrl: eachPhoto.src!.portrait!);
                            }),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
