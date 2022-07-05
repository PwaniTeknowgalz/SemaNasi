import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:semanasi/frontend/screens/dashboard.dart';
import 'backend/main_binding.dart';
import 'frontend/auth/login.dart';
import 'frontend/screens/dash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var keyParseApplicationId = "T3AOj3qSiFh0Y8l2jF8Li6Vb4smGJQ8rYb01McIX";
  var keyParseServerUrl = "https://parseapi.back4app.com";
  var keyParseClientKey = "CpA87GrXhF66n1YHtdpgDWpIboGLcSKq2CQH8edQ";

  var store = await CoreStoreSembastImp.getInstance(password: "mobipeace");

  await Parse().initialize(keyParseApplicationId, keyParseServerUrl,
      clientKey: keyParseClientKey, autoSendSessionId: true, coreStore: store);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MainBinding(),
      title: 'MobiPeace',
      theme: ThemeData(
        // textTheme: GoogleFonts.oxygenTextTheme(
        //   Theme.of(context).textTheme,
        // ),
        primarySwatch: Colors.teal,
      ),
      //home: const SplashScreen(),
      home: const Login(),
      builder: (BuildContext context, Widget? child) {
        return FlutterSmartDialog(child: child);
      },
    );
  }
}
