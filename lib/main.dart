import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHme(),
    );
  }
}

class MyHme extends StatefulWidget {
  const MyHme({Key key}) : super(key: key);

  @override
  State<MyHme> createState() => _MyHmeState();
}

class _MyHmeState extends State<MyHme> {
  num position = 1;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showExitPopup() {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.TOPSLIDE,
        title: 'Exit App',
        desc: 'Do you want to exit an App?',
        btnOkText: "Yes",
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          exit(0);
        },
      )..show();
    }

    return WillPopScope(
      child: Scaffold(
        body: IndexedStack(index: position, children: <Widget>[
          WebView(
            initialUrl: 'https://www.programiz.com',
            javascriptMode: JavascriptMode.unrestricted,
            key: key,
            onPageFinished: doneLoading,
            onPageStarted: startLoading,
          ),
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.blue,
            child: Center(
                child: SizedBox(
                  height: 150,
                    width: 150,
                    child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 10,
            ))),
          ),
        ]),
      ),
      onWillPop: () => showExitPopup(),
    );
  }
}
