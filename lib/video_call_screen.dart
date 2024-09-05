import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_call/zoom_service.dart'; // Import your ZoomService

class VideoCallScreen extends StatelessWidget {
  final TextEditingController _meetingIdController = TextEditingController();
  final TextEditingController _meetingPasswordController = TextEditingController();

  final ZoomService _zoomService = Get.find<ZoomService>();

  void _startMeeting() async {
    final meetingId = _meetingIdController.text.trim();
    final meetingPassword = _meetingPasswordController.text.trim();

    if (meetingId.isEmpty) {
      Get.snackbar('Error', 'Meeting ID is required');
      return;
    }

    try {
      final result = await _zoomService.startMeeting(meetingId, meetingPassword);
      if (result) {
        Get.snackbar('Success', 'Meeting started successfully');
      } else {
        Get.snackbar('Error', 'Failed to start the meeting');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Join a Meeting')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _meetingIdController,
              decoration: InputDecoration(labelText: 'Meeting ID'),
            ),
            TextField(
              controller: _meetingPasswordController,
              decoration: InputDecoration(labelText: 'Meeting Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startMeeting,
              child: Text('Start Meeting'),
            ),
          ],
        ),
      ),
    );
  }
}
