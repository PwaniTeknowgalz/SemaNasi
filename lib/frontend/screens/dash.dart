import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semanasi/frontend/screens/cases.dart';
import 'package:semanasi/frontend/screens/resources.dart';

import '../widgets/dash_card.dart';

class Dash extends StatelessWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/dashbdscreen.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(color: Colors.black.withOpacity(.275)),
          ),
          Container(
            width: Get.width,
            height: Get.height,
            child: Column(
              children: [
                //adding top space
                SizedBox(
                  height: 20,
                ),
                //Top navigation
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    //Icon button
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                    //expanded to occupy the remaining space
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                //add space
                SizedBox(
                  height: Get.height * .15,
                ),
                //adding Title
                Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "SemaNasi",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      //Custom divider
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        width: 60,
                        height: 1,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Welcome to SemaNasi\nWe are happy you are here with us",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  width: Get.width,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 10),
                      Text(
                        "Actions",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Dashcard(
                              img: "img/reportscreen.jpg",
                              title: "Cases",
                              subtitle: "Report and view vernacular hatespeech",
                              onClick: () {
                                Get.to(() => Cases());
                              }),
                          Dashcard(
                            img: "img/edcscreen.jpg",
                            title: "Civic education",
                            subtitle: "Civic education resources",
                            onClick: () {
                              Get.to(() => Resources());
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
