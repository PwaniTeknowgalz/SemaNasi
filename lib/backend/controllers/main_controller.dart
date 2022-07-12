import 'dart:io';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart';
import 'package:semanasi/utils/app_utils.dart';

import 'auth_controller.dart';

class MainController extends GetxController {

  var resources = {}.obs;
  var selectedResource = Rxn<ParseObject>();


  var cases = {}.obs;
  var selectedCase = Rxn<ParseObject>();
  var image = "".obs;

  static MainController get to => Get.find();


  //Sample Query fetching generic data
  fetchSimpleData({model}) async {
    ParseObject reqObj = ParseObject(model);
    QueryBuilder<ParseObject> query;
    query = QueryBuilder<ParseObject>(reqObj);
    var data = await query.find();
    if (data.isNotEmpty) {
      return data;
    }

    return null;
  }

  //Sample Query using userid
  fetchSimpleDataUsingUser({model, userId}) async {
    ParseObject reqObj = ParseObject(model);
    QueryBuilder<ParseObject> query;

    if (userId) {
      query = QueryBuilder<ParseObject>(reqObj)
        ..whereEqualTo('user', AuthController.to.parseUser.value?.objectId);
    } else {
      query = QueryBuilder<ParseObject>(reqObj);
    }

    var data = await query.find();
    if (data.isNotEmpty) {
      data;
    }
  }

  //fetching resources data
  fetchResourcesData() async {
    AppUtils.showLoading();
    try {
      ParseObject reqObj = ParseObject("Resources");
      QueryBuilder<ParseObject> query;
      query = QueryBuilder<ParseObject>(reqObj);
      //   ..whereEqualTo('user', AuthController.to.parseUser.value?.objectId);
      var data = await query.find();
      if (data.isNotEmpty) {
        //print("Not Empty");
        var resCurrent = resources.value;
        for (var res in data) {
          var mres = res as ParseObject;

          resCurrent[mres.objectId] = mres;
        }
        resources.value = resCurrent;
        resources.refresh();
      }
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      print(e.message);
      AppUtils.showError("Resource Fetching Failed!");
    }
    SmartDialog.dismiss();
  }

  //save Case data
  saveCase({required String file, title, content, required type}) async {
    var ext = extension(file);
    // var mfile = file.renameSync(
    //     (await getApplicationDocumentsDirectory()).path + "res_image$ext");

    var parseFile = ParseFile(File(file), debug: true, name: "case_image$ext");
    var caseItem = ParseObject("Cases")
      ..set("title", title)
      ..set("translation", content)
      ..set("type", type)
      ..set("approved",true)
      ..set("author", AuthController().parseUser.value)
      ..set("image", parseFile);

    if (selectedCase.value != null) {
      caseItem = ParseObject("Cases")
        ..objectId = selectedResource.value?.objectId
        ..set("title", title)
        ..set("translation", content)
        ..set("image", parseFile)
        ..set("type", type)
        ..set("author", AuthController().parseUser.value);

      // if (file != "") {
      //   resource.set("image", parseFile);
      // }
    }
    AppUtils.showLoading();
    try {
      ParseResponse? response = await caseItem.save();

      if (response.success) {
        // var data = response.result;
        // var allRes = cases.value;
        // allRes[data.objectId] = data;

        // cases.value = allRes;

        AppUtils.showSuccess("Case Saved Successfully!");
        SmartDialog.dismiss();
        Get.back();
        return true;
      } else {
        print(response.error?.message);
        AppUtils.showError("Case Saving Failed!");
      }
      SmartDialog.dismiss();
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      AppUtils.showError("Case Saving Failed!");
    }

    return false;
  }

    //fetching Cases data
  fetchCases() async {
    AppUtils.showLoading();
    try {
      ParseObject reqObj = ParseObject("Cases");
      QueryBuilder<ParseObject> query;
      query = QueryBuilder<ParseObject>(reqObj)
         ..whereEqualTo('approved', true);
      var data = await query.find();
      if (data.isNotEmpty) {
        //print("Not Empty");
        cases.clear();
        cases.refresh();
        var caseCurrent = cases.value;
        for (var case1 in data) {
          var mcase = case1 as ParseObject;

          caseCurrent[mcase.objectId] = mcase;
        }
        cases.value = caseCurrent;
        cases.refresh();
      }else{
         cases.clear();
         cases.refresh();
      }
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      print(e.message);
      AppUtils.showError("Cases Fetching Failed!");
    }
    SmartDialog.dismiss();
  }

  addComment({content}) async {
    initializeDateFormatting();

    var comment = {
      "content": content,
      "createdAt":DateFormat.yMd().add_Hm().format(DateTime.now()),
      "author": {
        "name": AuthController.to.parseUser.value?.get("name"),
        "email": AuthController.to.parseUser.value?.emailAddress,
        "objectId": AuthController.to.parseUser.value?.objectId
      }
    };

    //selectedResource.value?.setAdd("comments", comment);

    AppUtils.showLoading();
    try {
      var resource = ParseObject("Cases")
        ..objectId = selectedCase.value?.objectId ?? ""
        ..setAdd("comments", comment);
      ParseResponse? response = await resource.save();

      if (response.success) {
        var apiResponse = await ParseObject('Cases')
            .getObject(selectedCase.value?.objectId ?? "");
        // var queryBuilder  = QueryBuilder<ParseObject>(ParseObject("Resources"))
        //   ..whereEqualTo('objectId', selectedResource.value?.objectId ?? "");
        //
        // var apiResponse = await queryBuilder.query();
        if (apiResponse.success && apiResponse.result != null) {
          selectedCase.value = apiResponse.results?.first;
          selectedCase.refresh();
          var allRes = cases.value;
          allRes[selectedCase.value?.objectId] = selectedCase.value;
          cases.value = allRes;
          cases.refresh();
        }
        AppUtils.showSuccess("Comment Saved Successfully!");
      } else {
        print(response.error?.message);
        AppUtils.showError("Comment Saving Failed!");
      }
      SmartDialog.dismiss();
      return true;
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      AppUtils.showError("Comment Saving Failed!");
    }
    SmartDialog.dismiss();
    return false;
  }
}
