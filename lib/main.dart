import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_call/video_call_screen.dart';
import 'package:zoom_call/home_screen.dart'; // Import your HomeScreen if you have one
import 'package:zoom_call/zoom_service.dart'; // Import your ZoomService

void main() {
  // Register ZoomService with GetX
  Get.put(ZoomService());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zoom Call App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()), // Your home screen if you have one
        GetPage(name: '/videoCall', page: () => VideoCallScreen()),
      ],
    );
  }
}
