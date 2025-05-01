import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:meeting/resources/auth_methods.dart';
import 'package:meeting/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final JitsiMeet _jitsiMeet = JitsiMeet();

  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    String name;
    if (username.isEmpty) {
      name = _authMethods.user.displayName!;
    } else {
      name = username;
    }
    _firestoreMethods.addToMeetingHistory(roomName);
    try {
      var options = JitsiMeetConferenceOptions(
        serverURL: "https://meet.jit.si",
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
        },
        featureFlags: {
          "unsaferoomwarning.enabled": false,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: name,
          email: _authMethods.user.email,
          avatar: _authMethods.user.photoURL,
        ),
      );

      var listener = JitsiMeetEventListener(
        conferenceJoined: (url) {
          debugPrint("✅ Conference Joined: $url");
        },
        conferenceTerminated: (url, error) {
          debugPrint("❌ Conference Ended: $url, Error: $error");
        },
        participantJoined: (email, name, role, participantId) {
          debugPrint("👤 Participant Joined: $name");
        },
        participantLeft: (participantId) {
          debugPrint("🚪 Participant Left: $participantId");
        },
      );

      await _jitsiMeet.join(options, listener);
    } catch (e) {
      debugPrint("❗ Hata oluştu: $e");
    }
  }
}
