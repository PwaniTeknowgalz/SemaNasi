import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:semanasi/frontend/screens/reporting.dart';
import 'package:semanasi/frontend/widgets/custom_button.dart';
import 'package:semanasi/utils/app_constants.dart';

import '../widgets/custom_text_field.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({Key? key}) : super(key: key);

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.only(top: 65),
        width: Get.size.width,
        height: Get.size.height,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: Get.size.height * .03),
                SizedBox(height: 25),
                Text("Report vernacular hatespeech",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.black87)),
                SizedBox(height: 25),
                Container(
                  margin: EdgeInsets.all(10),
                  //show file name here
                  child: Text(
                    "No file uploaded",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  //show progress status here
                ),

                Container(
                    child: TextButton.icon(
                  onPressed: () {
                    //  selectFile();
                  },
                  icon: Icon(Icons.folder_open),
                  label: Text(
                    "CHOOSE FILE",
                    style: TextStyle(color: Colors.white),
                  ),
                  style:
                      TextButton.styleFrom(backgroundColor: AppConst.mainColor),
                )),
                SizedBox(
                  height: 12,
                ),
                //Title field
                CustomTextField(
                    title: "Title",
                    iconData: Icons.email_sharp,
                    name: "title",
                    textInputType: TextInputType.emailAddress),
                SizedBox(height: 12),
                //Description field
                CustomTextField(
                    title: "Translate",
                    iconData: Icons.lock_sharp,
                    name: "translate",
                    obscure: true,
                    textInputType: TextInputType.text),
                SizedBox(height: 5),

                SizedBox(height: 25),
                CustomButton(
                  onPressed: (() {
                    Get.to(() => Reporting());
                  }),
                  title: "Submit",
                ),
                SizedBox(height: 10),

                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
