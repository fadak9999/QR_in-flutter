import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //!_________________________________________________________
 final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');//final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
// تعريف مفتاح عالمي (GlobalKey) يُستخدم لربط وتحكم في ويدجت الـ QR Code Scanner (QRView). يُسهل من الوصول والتحكم في هذا الـ Widget.
 
  QRViewController?controller; //هذا المتغير يتحكم في الـ QR Code Scanner، مثل بدء المسح أو التوقف عنه.
  String qrText = 'Scan a QR Code';

//!________________________________________________________

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller =
          controller; //يتم تعيين الـ controller الذي تم تمريره إلى controller الخاص بالصفحة.
    });
    controller.scannedDataStream.listen((scanData) {
      //يستمع لتيار البيانات الممسوحة ضوئيًا من QR Code ويحدث النص (qrText) بناءً على البيانات التي تم استخراجها.
      setState(() {
        qrText = scanData.code ?? 'No QR Code Found';
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

//!___________________________________________________________
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('QR Code Scanner'),
      ),
      body: Column(
        children: [
         
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            height: 500,
            child: QRView(//QRView هو ويدجت يعرض الكاميرا ويمكّن المستخدم من مسح QR Code
              key:qrKey, //qrKey للتحكم في هذا الويدجت، ويمرر _onQRViewCreated لضبط الكاميرا ومعالجة بيانات المسح.
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
       //////////
          Expanded(
            flex: 1,
            child: Center(
              child: Text(qrText),
            ),
          ),
        ],
      ),
    );
  }
}
///////////////////////////////////////////////////////////////////////














//?_______________________________________________________________________________________
//todo--الاذونات التي يجب تفعيلها لتحليل الباركود 
//todo--   android /app /src /main / AndroidManifest.xml
// <manifest xmlns:android="http://schemas.android.com/apk/res/android"
//package="com.example.qr">//!i   هذا السطر يضاف  
// <uses-permission android:name="android.permission.CAMERA"/>//!  هذا السطر يضاف
// <uses-feature android:name="android.hardware.camera" android:required="true"/>
//     <application
//?_______________________________________________________________________________________
//todo اغير الاصدار
//todo   android/app/build.gradle
//  defaultConfig {
//         // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//         applicationId "com.example.qr"
//         // You can update the following values to match your application needs.
//         // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
//         minSdkVersion 20//! هذا يصبح 20
//         targetSdkVersion flutter.targetSdkVersion
//         versionCode flutterVersionCode.toInteger()
//         versionName flutterVersionName
//     }

//?_______________________________________________________________________________________
//todo المكتبه التي تضاف ..>> qr_code_scanner: ^1.0.1