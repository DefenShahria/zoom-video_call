package com.example.zoom_call

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.zoom.sdk.ZoomSDK
import com.zoom.sdk.ZoomSDKInitParams
import com.zoom.sdk.ZoomSDKInitListener

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.yourcompany.yourapp/zoom"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "initializeZoom" -> {
                        initializeZoom(result)
                    }
                    "startMeeting" -> {
                        val meetingId = call.argument<String>("meetingId")
                        val meetingPassword = call.argument<String>("meetingPassword")
                        startMeeting(meetingId, meetingPassword, result)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun initializeZoom(result: MethodChannel.Result) {
        val zoomSDK = ZoomSDK.getInstance()
        val initParams = ZoomSDKInitParams().apply {
            appKey = "YOUR_SDK_KEY"
            appSecret = "YOUR_SDK_SECRET"
            domain = "zoom.us"
        }

        zoomSDK.initialize(applicationContext, initParams, object : ZoomSDKInitListener {
            override fun onZoomSDKInitializeResult(resultCode: Int, errorMessage: String) {
                if (resultCode == ZoomErrorCode.SUCCESS) {
                    result.success("success")
                } else {
                    result.error("ERROR", errorMessage, null)
                }
            }

            override fun onZoomAuthIdentityExpired() {}
        })
    }

    private fun startMeeting(meetingId: String?, meetingPassword: String?, result: MethodChannel.Result) {
        val zoomSDK = ZoomSDK.getInstance()
        val meetingService = zoomSDK.meetingService

        val params = MeetingStartParams().apply {
            meetingNo = meetingId
            password = meetingPassword
        }

        val startMeetingResult = meetingService.startMeetingWithParams(this, params)
        if (startMeetingResult == MeetingErrorCode.SUCCESS) {
            result.success("success")
        } else {
            result.error("ERROR", "Failed to start meeting", null)
        }
    }
}
