import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semanasi/utils/app_constants.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConst.mainColor,
        body: SingleChildScrollView(
          child: Container(
            width: Get.size.width,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                //adding space
                SizedBox(
                  height: 50,
                ),
                //adding app logo
                Image(
                  image: AssetImage("img/first_logo.jpeg"),
                  height: 75,
                  width: 75,
                ),
                //adding space
                SizedBox(
                  height: 30,
                ),
                Text(
                  "We are Semanasi!! \n Tulielewa ulichosema",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                //adding space
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: Get.size.width,
                  height: Get.size.height * 0.25,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: AppConst.secColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: Icon(
                            Icons.info,
                            size: 32,
                            color: Colors.blue,
                          ),
                          title: Text("Report a Case"),
                          subtitle: Text("We got you"),
                          trailing: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue),
                            child: Text("45 Cases"),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Lets collaborate to maintain peace",
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                //adding space
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: Get.size.width,
                  height: Get.size.height * 0.30,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: AppConst.mainColorLight,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.info,
                          size: 32,
                          color: Colors.blue,
                        ),
                        title: Text("Civic education materials"),
                        subtitle: Text("We got you"),
                        trailing: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue),
                          child: Text("over 100 materials"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Feel free to air your voice and be part of this peacebuilding team. please remember that a voice about that audio or video could save a life!",
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
