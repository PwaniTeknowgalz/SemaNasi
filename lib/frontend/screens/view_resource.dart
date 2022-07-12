import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:semanasi/backend/controllers/main_controller.dart';
import 'package:transparent_image/transparent_image.dart';

class View_Resource extends StatelessWidget {
  const View_Resource({Key? key}) : super(key: key);

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
                child: Stack(
                  children: [
                    ShaderMask(

                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [ Colors.black,Colors.transparent,],
                          ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: FadeInImage.memoryNetwork(
                          width: Get.width,
                          placeholder: kTransparentImage,
                          image: (MainController.to.selectedResource.value
                                      ?.get("image") as ParseFile)
                                  .url ??
                              "",
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                      child: Text(
                          "${MainController.to.selectedResource.value?.get("title")} ",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      bottom: 10,
                      right: 10,
                      left: 10,
                    ),
                  ],
                ),
              ),
              Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                      "${MainController.to.selectedResource.value?.get("content")} ",
                      style: TextStyle()))
            ],
          )

              // Scaffold(
              //     body: NestedScrollView(
              //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              //     return <Widget>[
              //       SliverAppBar(
              //         expandedHeight: Get.height * .45,
              //         floating: false,
              //         pinned: true,
              //         flexibleSpace: FlexibleSpaceBar(
              //             centerTitle: true,
              //             expandedTitleScale: 1.5,
              //             title: Obx(() => Container(
              //               padding: EdgeInsets.symmetric(horizontal: 10),
              //               child: Text("${MainController.to.selectedResource.value?.get("title")} ",
              //                     style: const TextStyle(
              //                       color: Colors.white,
              //                       fontSize: 16.0,
              //                     )),
              //             ),
              //             ),
              //             background: Container(
              //               // height: Get.height*.35,
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.only(
              //                 bottomLeft: Radius.circular(35),
              //                 bottomRight: Radius.circular(35),
              //               )),
              //               child: Image.asset(
              //                 "img/reportscreen.jpg",
              //                 fit: BoxFit.cover,
              //                 color: Colors.black.withOpacity(.6),
              //                 colorBlendMode: BlendMode.darken,
              //               ),
              //             )),
              //       ),
              //     ];
              //   },
              //   body: Container(
              //     width: Get.width,
              //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              //     child: Text("${MainController.to.selectedResource.value?.get("content")} ",style:TextStyle())),
              // body: Container(
              //   color: Colors.grey[100],
              //   child: ListView(
              //     padding: EdgeInsets.all(20),
              //     children: [
              //       SizedBox(
              //         height: 7,
              //       ),
              //       Text(
              //         "Reported vernacular hatespeech cases",
              //         style: TextStyle(
              //           fontSize: 18,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       SizedBox(
              //         height: 3,
              //       ),
              //       Text(
              //         "32 Cases available",
              //         style: TextStyle(
              //           fontSize: 15,
              //           color: Colors.grey[600],
              //         ),
              //       ),
              //       SizedBox(
              //         height: 16,
              //       ),

              //       //list item
              //       Container(
              //         width: Get.width,
              //         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.all(Radius.circular(5)),
              //             color: Colors.grey[300]),
              //         child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Container(
              //               width: 70,
              //               height: 70,
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.all(Radius.circular(5)),
              //                   image: DecorationImage(
              //                       image: AssetImage("img/edcscreen.jpg"),
              //                       fit: BoxFit.cover)),
              //             ),
              //             SizedBox(
              //               width: 7,
              //             ),
              //             Expanded(
              //               child: Text(
              //                 "Hatespeech seen on social media in French",
              //                 maxLines: 2,
              //                 overflow: TextOverflow.ellipsis,
              //                 style:
              //                     TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //       //end of list item
              //     ],
              //   ),
              // ),

              // Container(
              //   padding: EdgeInsets.all(20),
              //   width: Get.width,
              //   height: Get.height,
              //   child: ListView(
              //     children: [
              //       Row(
              //         children: [
              // //           Container(
              //             width: 60,
              //             height: 60,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.all(Radius.circular(10)),
              //                 image: DecorationImage(
              //                     image: AssetImage("img/edcscreen.jpg"),
              //                     fit: BoxFit.cover)),
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Expanded(
              //             child: Text(
              //               "Lorem Ipsum is simply dummy text",
              //               maxLines: 2,
              //               overflow: TextOverflow.ellipsis,
              //               style: TextStyle(fontSize: 16),
              //             ),
              //           ),
              //         ],
              //       ),
              //       //add divider
              //       Divider(
              //         thickness: 1,
              //         color: Colors.grey,
              //       ),
              //       Row(
              //         children: [
              //           Container(
              //             width: 60,
              //             height: 60,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.all(Radius.circular(10)),
              //                 image: DecorationImage(
              //                     image: AssetImage("img/edcscreen.jpg"),
              //                     fit: BoxFit.cover)),
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Expanded(
              //             child: Text(
              //               "Lorem Ipsum is simply dummy text",
              //               maxLines: 2,
              //               overflow: TextOverflow.ellipsis,
              //               style: TextStyle(fontSize: 16),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              )),
    );
  }
}
