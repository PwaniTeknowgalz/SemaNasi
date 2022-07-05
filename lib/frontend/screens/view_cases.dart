import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class View_cases extends StatelessWidget {
  const View_cases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: Get.height * .45,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Cases ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Container(
                  // height: Get.height*.35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  )),
                  child: Image.asset(
                    "img/reportscreen.jpg",
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(.6),
                    colorBlendMode: BlendMode.darken,
                  ),
                )),
          ),
        ];
      },
      body: Container(
        color: Colors.grey[100],
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 7,
            ),
            Text(
              "Reported vernacular hatespeech cases",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "32 Cases available",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: 16,
            ),

            //list item
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.grey[300]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(
                            image: AssetImage("img/edcscreen.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Text(
                      "Hatespeech seen on social media in French",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            //end of list item
          ],
        ),
      ),

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
    ));
  }
}
