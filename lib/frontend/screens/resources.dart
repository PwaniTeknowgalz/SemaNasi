import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:semanasi/backend/controllers/main_controller.dart';
import 'package:semanasi/frontend/screens/view_resource.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/side_navigation.dart';

class Resources extends StatefulWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {


  @override
  initState(){

    super.initState();
    Future.microtask(() async {
      await MainController.to.fetchResourcesData();
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        //child: Container(),
        child: Scaffold(
            backgroundColor: Colors.white,
             drawer: AppDrawerWidget().getDrawer("resources"),
            //extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: const Text("Civic Education"),
              centerTitle: true,
              actions: [
                IconButton(
            onPressed: () async {
              await MainController.to.fetchResourcesData();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            )),
              ],
              //automaticallyImplyLeading: false,
            ),
            body: Container(
              margin: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Obx(()=> StaggeredGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                
                    // itemCount: imageList.length,
                    // itemBuilder: (context, index) {
                    children: MainController.to.resources.value.keys.map((key) {
                      var item = MainController.to.resources.value[key];
                      return InkWell(
                        onTap: () {
                          MainController.to.selectedResource.value = item;
                          Get.to(()=>const View_Resource());
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: Stack(
                              children: [
                                ShaderMask(
                                    shaderCallback: (rect) {
                                      return const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.center,
                                        colors: [Colors.transparent, Colors.black],
                                      ).createShader(Rect.fromLTRB(
                                          0, 0, rect.width, rect.height));
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: (item["image"] as ParseFile).url??"",
                                      fit: BoxFit.cover,
                                    )),
                                Container(
                                  padding: const EdgeInsets.only(left: 10, top: 10),
                                  child:  Text(
                                    "${item["title"]}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    // },
                    // staggeredTileBuilder: (index) {
                    //   return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                    // }),
                    //   ),
                  ),
                ),
              ),
            )));
  }
}
