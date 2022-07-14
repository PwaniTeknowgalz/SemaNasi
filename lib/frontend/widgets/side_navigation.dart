import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semanasi/frontend/screens/cases.dart';
import 'package:semanasi/frontend/screens/resources.dart';

import '../../backend/controllers/auth_controller.dart';
import '../../utils/app_constants.dart';
import '../screens/dashboard.dart';

class AppDrawerWidget {
  getDrawer(page) {
    var sideNav = Drawer(
      width: Get.width*.7,
      child: Column(
        children: [
          Container(
            color: AppConst.mainColor,
            width: Get.width,
            padding: const EdgeInsets.only(top: 60,bottom: 20,left: 20,right:20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person,color: Colors.white,),
                ),
                const SizedBox(height: 20,),
                Text(
                  "${AuthController.to.parseUser.value?.get("name")}",

                  style:
                  const TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${AuthController.to.parseUser.value?.emailAddress}",
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: (){
              Get.offUntil(GetPageRoute(page: () => const Dashboard()), (route) => false);
            },
            leading: Icon(Icons.home_filled,color: page=="dashboard"?AppConst.accentColor:Colors.black45),
            title: Text("Dashboard",style: TextStyle(color: page=="dashboard"?AppConst.accentColor:Colors.black45,fontSize: 18),),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: (){
              Get.to(()=>const Cases());
            },
            leading: Icon(Icons.report,color: page=="cases"?AppConst.accentColor:Colors.black45),
            title: Text("Cases",style: TextStyle(color: page=="cases"?AppConst.accentColor:Colors.black45,fontSize: 18),),
          ),
          ListTile(
            onTap: (){
              Get.to(()=>const Resources());
            },
            leading: Icon(Icons.file_copy_sharp,color: page=="resources"?AppConst.accentColor:Colors.black45),
            title: Text("Civic Education",style: TextStyle(color: page=="resources"?AppConst.accentColor:Colors.black45,fontSize: 18),),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () async {
             await  AuthController.to.signOut();
            },
            leading: const Icon(Icons.logout,color: Colors.black45),
            title: const Text("Logout",style: TextStyle(color: Colors.black45,fontSize: 18),),
          )
        ],
      ),
    );
    return sideNav;
  }
}


