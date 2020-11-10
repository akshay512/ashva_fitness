import 'dart:convert';

import 'package:ashva_fitness_example/constants/const.dart';
import 'package:ashva_fitness_example/model/allImagesModel.dart';
import 'package:ashva_fitness_example/services/httpRequestBody.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_view/photo_view.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<dynamic> allImagesModel;

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  double width, height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllImages();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Constants.darkPrimary,
              Constants.lightPrimary,
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          )),
          child: allImagesModel != null
              ? ListView(
                  children: <Widget>[
                    // Center(
                    //     child: Text(
                    //   // 'ashva gallery',
                    //   style: TextStyle(color: Colors.white, fontSize: 18),
                    // )),
                    SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: allImagesModel.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (allImagesModel[index]["fileName"] != "") {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: PhotoView(
                                            backgroundDecoration: BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                            imageProvider:
                                                CachedNetworkImageProvider(
                                                    allImagesModel[index]
                                                        ["fileName"]),
                                          ),
                                        ));
                              }
                            },
                            child: Container(
                              // width: width * 0.4,
                              // height: height * 0.2,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "http://104.197.184.236:8443/api/downloadFile/${allImagesModel[index]["fileName"]}",
                                httpHeaders: {
                                  'Authorization':
                                      prefs.get('auth_token').toString()
                                },
                                fit: BoxFit.fill,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Container(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          );
                        })
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  Future<void> getAllImages() async {
    try {
      final encoding = Encoding.getByName('utf-8');

      Response response = await post(uriList['getAllImages'],
          headers: {'Authorization': prefs.get('auth_token').toString()},
          encoding: encoding);
      // Response response = await newHttpPost(uri: uriList['getAllImages']);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          print(response.body);
          allImagesModel = jsonDecode(response.body);
        });
      }
    } catch (e) {
      print(e);
    }
    print("loading done for all images ");
  }
}
