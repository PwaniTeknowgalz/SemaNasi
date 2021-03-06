import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semanasi/backend/controllers/main_controller.dart';
import 'package:semanasi/frontend/screens/report_form.dart';
import 'package:semanasi/frontend/screens/view_cases.dart';
import 'package:semanasi/frontend/widgets/cases_widget.dart';

import '../widgets/side_navigation.dart';

class Cases extends StatelessWidget {
  const Cases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawerWidget().getDrawer("cases"),
      extendBodyBehindAppBar: true,
      appBar:
          AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("img/reportscreen.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.darken),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * .15,
            ),
            Container(
              width: Get.width * .2,
              height: Get.width * .2,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(
                        "img/first_logo.jpeg",
                      ),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.contain)),
            ),
            SizedBox(
              height: Get.height * .1,
            ),
            const Text(
              "Select an action",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 26),
            ),
            SizedBox(
              height: Get.height * .1,
            ),
            Case_button(
              iconData: Icons.mic,
              title: "Report and translate vernacular hatespeech",
              onClick: () {
                MainController.to.selectedCase.value=null;
                MainController.to.image.value ="";
                Get.to(() => const ReportForm());
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Case_button(
              iconData: Icons.image,
              title: "View reported cases",
              onClick: () {
                Get.to(() => const ViewCases());
              },
            ),
          ],
        ),
      ),
    );
  }
}
