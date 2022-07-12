import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semanasi/backend/controllers/main_controller.dart';
import 'package:semanasi/frontend/screens/view_single_case.dart';
import 'package:semanasi/utils/app_constants.dart';

class ViewCases extends StatefulWidget {
  const ViewCases({Key? key}) : super(key: key);

  @override
  State<ViewCases> createState() => _ViewCasesState();
}

class _ViewCasesState extends State<ViewCases> {

   @override
  initState(){

    super.initState();
    Future.microtask(() async {
      await MainController.to.fetchCases();
    });
  }
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
                title: const Text("Cases ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Container(
                  // height: Get.height*.35,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(35),
                    bottomRight: const Radius.circular(35),
                  )),
                  child: Image.asset(
                    "img/reportscreen.jpg",
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(.6),
                    colorBlendMode: BlendMode.darken,
                  ),
                )),
                actions: [
                  IconButton(
                    onPressed: () async {
                     await MainController.to.fetchCases(); 
                    },
                    icon: const Icon(
                      Icons.refresh,
                    ),
                  )
                ],
          ),
        ];
      },
      body: Container(
        color: Colors.grey[100],
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(
              height: 7,
            ),
            const Text(
              "Reported vernacular hatespeech cases",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Obx(()=>Text(
                "${MainController.to.cases.value.keys.length} Cases available",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),

           _allCases()
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

_allCases() {
 //list item
   return  Obx(()=>Column(
       children:MainController.to.cases.value.keys.map((key) {
        var item = MainController.to.cases.value[key];
        return  InkWell(
          onTap: (){
            MainController.to.selectedCase.value = item;
            MainController.to.selectedCase.refresh();
            Get.to(()=>const ViewSingleCase());
          },
          child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey[300]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: AppConst.mainColor
                                  ),
                                  child: Icon(_getTypeIcon(item.get("type")),color: Colors.white,size: 50,),
                            ),
                          
                          const SizedBox(
                            width: 7,
                          ),
                          Expanded(
                            child: Text(
                              "${item.get("title")}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
        );
       
       }).toList(),
     ),
   );
            //end of list item
}

_getTypeIcon(type) {
  if(type=="IMAGE") {
    return Icons.image;
  }

  if(type=="VIDEO"){
    return Icons.video_file;
  }

  return Icons.audio_file;

}
