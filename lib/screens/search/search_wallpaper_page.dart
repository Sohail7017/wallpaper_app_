import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/api_utility/util_helper.dart';
import 'package:wallpaper_app/constants/app_constant.dart';
import 'package:wallpaper_app/screens/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/screens/search/cubit/search_wallpaper_state.dart';
import 'package:wallpaper_app/screens/wallpaper_detail_page.dart';
import 'package:wallpaper_app/widgets/wallpaper_widget.dart';

import '../../models/trending_wallpaper_model.dart';


class SearchWallpaperPage extends StatefulWidget {
  String query;
  String color;
  SearchWallpaperPage({required this.query,this.color= ""});

  @override
  State<SearchWallpaperPage> createState() => _SearchWallpaperPageState();
}

class _SearchWallpaperPageState extends State<SearchWallpaperPage> {

  ScrollController? scrollController;
 num totalWallpaperCount = 0;
 int totalNoPages = 1;
 int pageCount = 1;
 List<Photos> allWallpapers = [];
  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    scrollController!.addListener( (){
      if(scrollController!.position.pixels == scrollController!.position.maxScrollExtent){
        /// End of list

        totalNoPages = totalWallpaperCount~/15+1;
        if(totalNoPages>pageCount){
          pageCount++;
          BlocProvider.of<SearchCubit>(context).getSearchWallpapers(query: widget.query,color: widget.color,page: pageCount);

        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("You've reached the end of this category Wallpapers")));
        }
      }
    });
    BlocProvider.of<SearchCubit>(context).getSearchWallpapers(query: widget.query,color: widget.color);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: BlocListener<SearchCubit,SearchWallpaperState>(
          listener: (_,state){
            if(state is SearchLoadingState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pageCount!=1 ?'Next Page Loading...': "Loading...")));
            }else if(state is SearchErrorState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.errMsg}")));
            }else if(state is SearchLoadedState){
              totalWallpaperCount = state.totalWallpapers!;
              allWallpapers.addAll(state.listPhotos);
              setState(() {

              });
            }
              },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.query,style: mTextStyle25(mFontWeight: FontWeight.bold),),
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)))
                    ],
                  ),
                  Text("${totalWallpaperCount} Wallpapers available",style: mTextStyle16(mFontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(

                      child: GridView.builder(
                          controller: scrollController,
                          shrinkWrap: true,

                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 11,
                              mainAxisSpacing: 10,
                              childAspectRatio: 2/3
                          ),
                          itemCount: allWallpapers.length,
                          itemBuilder: (_,index){
                            var eachPhoto = allWallpapers[index];
                            return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => WallpaperDetailPage(imageModel: eachPhoto.src!)));
                                },
                                child: WallpaperWidget(imgUrl: eachPhoto.src!.portrait!));
                          }),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
