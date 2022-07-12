import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:semanasi/backend/controllers/main_controller.dart';
import 'package:semanasi/utils/app_utils.dart';
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

    if (MainController.to.selectedCase.value != null &&
        ["VIDEO", "AUDIO"]
            .contains(MainController.to.selectedCase.value?.get("type"))) {
      _controller = VideoPlayerController.network(
          '${(MainController.to.selectedCase.value?.get("image") as ParseFile).url}')
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    } else {
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
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black54,
        ),
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
             
              Container(
                  height: Get.height * .40,
                  width: Get.width,
                  color: Colors.black,
                  child: _getWidgetUsingType(
                      MainController.to.selectedCase.value?.get("type"),
                      MainController.to.selectedCase.value?.get("image"),
                      _controller)),
              
              Container(
                margin: EdgeInsets.only(top: Get.height * .40,bottom: 80),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Text(
                              "${MainController.to.selectedCase.value?.get("title")} ",
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                      Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Text(
                              "${MainController.to.selectedCase.value?.get("translation")} ",
                              style: const TextStyle())),

                      const SizedBox(
                        height: 20,
                      ),
                      
                      Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: AlignmentDirectional.centerStart,
                        child: Text("Comments(${MainController.to.selectedResource.value?.get("comments")==null?0:MainController.to.selectedResource.value?.get("comments").length}): ",textAlign: TextAlign.start, style: TextStyle(fontSize: 12),)),
                    const SizedBox(height: 10,),
    Obx(() { return _showComments();}),
                    ],
                  ),
                ),
              ),
              
              Container(
                child: [
                  "VIDEO",
                  "AUDIO"
                ].contains(MainController.to.selectedCase.value?.get("type"))
                    ? FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                      )
                    : Container(),
                margin: EdgeInsets.only(top: ((Get.height * .40)-25),right:20),
                width: Get.width,
                alignment: AlignmentDirectional.topEnd,
              ),
               Positioned(
                bottom: 0,
                child: Container(
                  width: Get.width,
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 5,bottom:5,right: 5,left:5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: FormBuilder(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            children: <Widget>[
                              FormBuilderTextField(
                                name: 'comment',
                              
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: "Write a comment..."),
                                // onChanged: _onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                keyboardType: TextInputType.text,
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(onPressed: () async {
                        await _saveComment(_formKey.currentState);
                      }, child: const Icon(Icons.send))
                    ],
                  ),
                ),
              ),
           
               ],
          ),
        ),
      ),
    );
  }
}

_getWidgetUsingType(type, file, _controller) {
  switch (type) {
    case "IMAGE":
      return FadeInImage.memoryNetwork(
        width: Get.width,
        placeholder: kTransparentImage,
        image: (MainController.to.selectedCase.value?.get("image") as ParseFile)
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
                    ["AUDIO"].contains(
                            MainController.to.selectedCase.value?.get("type"))
                        ? Container(
                            color: Colors.black,
                            width: Get.width,
                            height: Get.height,
                            child: const Icon(
                              Icons.audio_file,
                              color: Colors.white,
                              size: 70,
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                  ],
                ),
              )
            : Container(),
      );
  }
}
_showComments(){
  var comments = MainController.to.selectedCase.value?.get("comments");
  print(comments);
   if(comments == null){
     return Container();
   }
  comments = (comments as List).reversed.toList();
  return Column(
    children: comments.map<Widget>((e) {
      return Container(
          width:Get.width,
        alignment: AlignmentDirectional.centerStart,
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${e["author"]["name"].trim()}", style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text("${e["content"].trim()}", style: TextStyle()),
            SizedBox(height:10,),
            Text("${e["createdAt"].trim()}", style: TextStyle(fontSize: 8,)),
          ],
        ),
      );
    }).toList() ,
  );
}
_saveComment(FormBuilderState? currentState) async {
  //AppUtils.showLoading();
  //print("TTTT");
  if(currentState!=null){
    currentState.save();
    print(currentState.value);
  }
  if(currentState==null || !currentState.isValid){
    AppUtils.showError("Entered data is invalid or fields are empty!");
    return;
  }



  var comment = currentState.value["comment"];

  await MainController.to.addComment(content: comment);

  SmartDialog.dismiss();

  currentState.reset();
}