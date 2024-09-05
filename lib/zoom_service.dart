import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ZoomService extends GetxService {
  static ZoomService get to => Get.find();

  final MethodChannel _channel = MethodChannel('com.yourcompany.yourapp/zoom');

  Future<bool> startMeeting(String meetingId, String meetingPassword) async {
    try {
      final result = await _channel.invokeMethod('startMeeting', {
        'meetingId': meetingId,
        'meetingPassword': meetingPassword,
      });
      return result == 'success';
    } catch (e) {
      throw Exception('Failed to start meeting: $e');
    }
  }
}
