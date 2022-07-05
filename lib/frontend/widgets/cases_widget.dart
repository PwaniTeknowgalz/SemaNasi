import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semanasi/utils/app_constants.dart';

class Case_button extends StatelessWidget {
  const Case_button(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.onClick})
      : super(key: key);
  final IconData iconData;
  final String title;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * .1,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white70.withOpacity(.4),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppConst.mainColor,
          ),
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        onTap: onClick,
      ),
    );
  }
}
