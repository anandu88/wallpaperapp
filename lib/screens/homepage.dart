import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/keys.dart';
import 'package:wallpaperapp/screens/imagescreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List images=[];
  int page=1;
   @override
  void initState() {
    super.initState();
    fetchapi();
  }
    
  
  fetchapi()async{
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
    headers: {
      'Authorization':API_KEY
    }).then((value) {
      Map result=jsonDecode(value.body);
      setState(() {
        images=result['photos'];
      });
      print(images);
      

    });
    
  }
  loadmore()async{
    setState(() {
      page=page + 1;
    });
      String url =
        'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
         await http.get(Uri.parse(url),
    headers: {
      'Authorization':API_KEY
    }).then((value) {
      Map result=jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
      
      

    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container(
            child: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2/3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2
              ),
              itemCount: images.length,
             itemBuilder: (context, index) {
               return InkWell(onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Imagescreen(imageurl: images[index]['src']['large2x']),));
               },
                 child: Container(color: Colors.white,
                 child: Image.network(
                            images[index]['src']['tiny'],
                            fit: BoxFit.cover,
                          ),),
               );
             },),
          )),
          InkWell(onTap: loadmore,
            
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child: Text('Load More',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}