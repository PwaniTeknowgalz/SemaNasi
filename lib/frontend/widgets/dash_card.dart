import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashcard extends StatelessWidget {
  const Dashcard(
      {Key? key,
      required this.onClick,
      required this.img,
      required this.title,
      required this.subtitle})
      : super(key: key);
  final VoidCallback onClick;
  final String img, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Stack(
        children: [
          Container(
            width: Get.width * .4,
            height: Get.height * .32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image:
                    DecorationImage(image: AssetImage(img), fit: BoxFit.cover)),
          ),
          Container(
            padding: EdgeInsets.all(12),
            width: Get.width * .4,
            height: Get.height * .32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(.4)),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
