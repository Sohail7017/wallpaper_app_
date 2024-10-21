import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/api_utility/util_helper.dart';
import 'package:wallpaper_app/constants/app_constant.dart';
import 'package:wallpaper_app/data/remote/api_helper.dart';
import 'package:wallpaper_app/data/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/screens/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/screens/search/search_wallpaper_page.dart';
import 'package:wallpaper_app/screens/wallpaper_detail_page.dart';

import 'package:wallpaper_app/widgets/wallpaper_widget.dart';

import 'cubit/wallpaper_cubit.dart';
import 'cubit/wallpaper_state.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    TextEditingController searchController = TextEditingController();
    @override
  void initState() {
     super.initState();
   BlocProvider.of<WallpaperCubit>(context).getTrendingWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,

      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
        SizedBox(
          height: 40,
        ),

          /// Search wallpaper Text Feild


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,),
            child: TextField(
              controller: searchController,  // Corrected this line
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.secondaryColor,
                suffixIcon: InkWell(
                  onTap: () {
                    if (searchController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => SearchCubit(
                              wallpaperRepository: WallpaperRepository(
                                apiHelper: ApiHelper(),
                              ),
                            ),
                            child: SearchWallpaperPage(query: searchController.text),
                          ),
                        ),
                      );
                    }
                  },
                  child: Icon(Icons.search, color: Colors.grey.shade400),
                ),
                hintText: 'Find Wallpapers....',
                hintStyle: mTextStyle14(
                  mColor: Colors.grey.shade400,
                  mFontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),


          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('Best of Month',style: mTextStyle16(mFontWeight: FontWeight.bold),),
          ),

          SizedBox(
            height: 10,
          ),

          /// Trending WallPapers

          SizedBox(
            height: 250,
            child: BlocBuilder<WallpaperCubit,WallpaperState>(
                builder: (_,state){
                  if(state is WallpaperLoadingState){
                    return Center(child: CircularProgressIndicator(),);
                  }else if(state is WallpaperErrorState){
                    return Center(child: Text("Error: ${state.errMsg}"),);
                  }else if (state is WallpaperLoadedState){
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.listPhotos.length,
                        itemBuilder: (_,index){
                          var eachPhoto = state.listPhotos[index];
                          return Padding(
                            padding:  EdgeInsets.only(left: 16, right: index==state.listPhotos.length-1 ? 16 : 0),
                            child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => WallpaperDetailPage(imageModel: eachPhoto.src!)));
                                },
                                child: WallpaperWidget(imgUrl: eachPhoto.src!.portrait!)),
                          );
                        });
                  }
                  return Container();
                })
          ),

          SizedBox(
            height: 25,
          ),

          /// Color Tone Images

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('The Color Tone',style: mTextStyle16(mFontWeight: FontWeight.bold),),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppConstant.mColor.length,
                itemBuilder: (_,index){
                  return Padding(
                    padding:  EdgeInsets.only(left: 16, right: index==AppConstant.mColor.length-1 ? 16 : 0),
                    child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => SearchCubit(
                                    wallpaperRepository: WallpaperRepository(
                                        apiHelper: ApiHelper())),
                          child: SearchWallpaperPage(
                            query: searchController.text.isNotEmpty ? searchController.text : "Nature",
                          color: AppConstant.mColor[index]['code'],
                          ),
                          )));
                        },
                        child: getColorTone(AppConstant.mColor[index]['color']))
                  );
                }),
          ),


          /// Category Wise Wallpapers

          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Categories',style: mTextStyle16(mFontWeight: FontWeight.bold),),
          ),
          SizedBox(
            height: 10,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
              crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 5/3
              ),
                itemCount: AppConstant.mCategories.length,
                itemBuilder: (_,index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => BlocProvider(
                              create: (context) => SearchCubit(
                                  wallpaperRepository: WallpaperRepository(
                                      apiHelper: ApiHelper())),
                          child: SearchWallpaperPage(query: AppConstant.mCategories[index]['title']),
                          )));
                    },
                    child: getCategoryWall(
                        AppConstant.mCategories[index]['image'],
                        AppConstant.mCategories[index]['title']),
                  );
                }),
          ),


        ],
      )
    );
  }

  Widget getColorTone(Color mColor){
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mColor
      ),
    );
  }

  Widget getCategoryWall(String imgPath, String title){
    return Container(
      width: 180,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(imgPath)),
      ),
      child: Center(child: Text(title,style: mTextStyle14(mColor: Colors.white,mFontWeight: FontWeight.bold),),),
    );
  }
}
