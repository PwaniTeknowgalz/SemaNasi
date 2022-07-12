import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:semanasi/frontend/screens/cases.dart';
import 'package:semanasi/frontend/screens/reporting.dart';
import 'package:semanasi/frontend/widgets/custom_button.dart';
import 'package:semanasi/utils/app_constants.dart';

import '../../backend/controllers/main_controller.dart';
import '../../utils/app_utils.dart';
import '../widgets/custom_text_field.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({Key? key}) : super(key: key);

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  var types = ["IMAGE", "VIDEO", "AUDIO"];
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: const EdgeInsets.only(top: 65),
        width: Get.size.width,
        height: Get.size.height,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: Get.size.height * .03),
                const SizedBox(height: 25),
                Text("Report vernacular hatespeech",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.black87)),
                const SizedBox(height: 25),
                Container(
                  margin: const EdgeInsets.all(10),
                  //show file name here
                  child: Obx(()=>Text(
                      MainController.to.image.value == "" ? "No file uploaded" : basename(MainController.to.image.value),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  //show progress status here
                ),

                Container(
                    child: TextButton.icon(
                  onPressed: () {
                    _selectFile();
                  },
                  icon: const Icon(Icons.folder_open),
                  label: const Text(
                    "CHOOSE FILE",
                    style: TextStyle(color: Colors.white),
                  ),
                  style:
                      TextButton.styleFrom(backgroundColor: AppConst.mainColor),
                )),
                const SizedBox(
                  height: 12,
                ),

                //File TYPE field
                FormBuilderDropdown(
                  name: 'type',
                  decoration: const InputDecoration(
                    labelText: 'File Type',
                  ),
                  initialValue: 'IMAGE',
                  icon: Icon(Icons.category),

                  allowClear: false,
                  hint: const Text('Select File Type'),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  items: types
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text('$type'),
                          ))
                      .toList(),
                      
                ),

                const SizedBox(
                  height: 16,
                ),
                //Title field
                const CustomTextField(
                    title: "Title",
                    iconData: Icons.book,
                    name: "title",
                    textInputType: TextInputType.name),
                const SizedBox(height: 12),
                //Description field
                FormBuilderTextField(
                    name: "translate",
                    maxLines: 5,
                    minLines: 5,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(
                        Icons.translate,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                      fillColor: Colors.grey[200],
                      focusColor: AppConst.mainColor.withOpacity(.8),
                    )),
                const SizedBox(height: 5),

                const SizedBox(height: 25),
                CustomButton(
                  onPressed: (() {
                    _saveResource(_formKey.currentState);
                  }),
                  title: "Submit",
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _selectFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path ?? "");

    if (file.existsSync()) {
      print(result.files.single.path);
      MainController.to.image.value = file.path;
    }
  } else {
    // User canceled the picker
    AppUtils.showError("No Image Selected");
  }
}

_saveResource(FormBuilderState? currentState) async {
  //AppUtils.showLoading();
  if (currentState != null) {
    currentState.save();
    print(currentState.value);
  }
  if (currentState == null || !currentState.isValid) {
    AppUtils.showModalMessage(
        message: "Entered data is invalid or fields are empty!",
        color: AppConst.error);
    return;
  }

  if (MainController.to.image.value == "") {
    AppUtils.showModalMessage(
        message: "No Image Selected!", color: AppConst.error);
    return;
  }

  var content = currentState.value["translation"];
  var title = currentState.value["title"];
  var type = currentState.value["type"];
  var fileUrl = "";
  if (File(MainController.to.image.value).existsSync()) {
    fileUrl = MainController.to.image.value;
  }
  await MainController.to
      .saveCase(file: fileUrl, content: content, title: title,type:type);
  Get.offUntil(GetPageRoute(page: () => const Cases()), (route) => Get.currentRoute=="/Dashboard");
  // SmartDialog.dismiss();
}
