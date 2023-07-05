import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Imagescreen extends StatefulWidget {
  final String imageurl;
  const Imagescreen({super.key, required this.imageurl});

  @override
  State<Imagescreen> createState() => _ImagescreenState();
}

class _ImagescreenState extends State<Imagescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
              Expanded(
            child: Container(
              child: Image.network(widget.imageurl),
            ),
          ),
          InkWell(onTap: setwallpaper,
            
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child: Text('set as wallpaper',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          )
          ],
        ),
      ),
    );
  }
  
  setwallpaper() async{
  var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
  int location = WallpaperManager.BOTH_SCREEN; //can be Home/Lock Screen
  await WallpaperManager.setWallpaperFromFile(file.path, location).then((value) =>
  Fluttertoast.showToast(msg: 'wallpaper changed'));
  
 }
}