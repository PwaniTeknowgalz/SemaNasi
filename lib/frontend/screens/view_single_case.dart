import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:semanasi/backend/controllers/main_controller.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';

class ViewSingleCase extends StatefulWidget {
  const ViewSingleCase({Key? key}) : super(key: key);

  @override
  State<ViewSingleCase> createState() => _ViewSingleCaseState();
}

class _ViewSingleCaseState extends State<ViewSingleCase> {

  late VideoPlayerController _controller;
 @override
  void initState() {
    super.initState();

    if(MainController.to.selectedCase.value!=null && ["VIDEO","AUDIO"].contains(MainController.to.selectedCase.value?.get("type"))) {
      _controller = VideoPlayerController.network(
        '${(MainController.to.selectedCase.value?.get("image") as ParseFile).url}')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    }else{
      _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black54,
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                height: Get.height * .45,
                width: Get.width,
                color: Colors.black,
                child: _getWidgetUsingType(MainController.to.selectedCase.value?.get("type"),MainController.to.selectedCase.value?.get("image"),_controller)
              ),
              Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                      "${MainController.to.selectedCase.value?.get("title")} ",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                      "${MainController.to.selectedCase.value?.get("translation")} ",
                      style: TextStyle()))
            ],
          )

             
              ),
              floatingActionButton: ["VIDEO","AUDIO"].contains(MainController.to.selectedCase.value?.get("type"))?FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ):null,
              ),
    );
  }
}

_getWidgetUsingType(type,file,_controller) {

  switch(type){
    case "IMAGE":
    return FadeInImage.memoryNetwork(
                          width: Get.width,
                          placeholder: kTransparentImage,
                          image: (MainController.to.selectedCase.value
                                      ?.get("image") as ParseFile)
                                  .url ??
                              "",
                          fit: BoxFit.cover,
                        );
    default:
    return Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                 
                  ["AUDIO"].contains(MainController.to.selectedCase.value?.get("type"))?Container(
                    color: Colors.black,
                    width: Get.width,
                    height: Get.height,
                    child: const Icon(
                      Icons.audio_file,
                      color: Colors.white,
                      size: 70,
                    ),
                  ):const SizedBox(height: 0,),
                   VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
                )
              : Container(),
        );

  }
  
}
