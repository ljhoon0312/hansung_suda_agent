import 'package:flutter/material.dart';
import 'models.dart';

class AppState extends ChangeNotifier {
  final List<AlarmModel> _alarms = [];
  final List<ScheduleModel> _schedules = [];
  ProfileModel _profile = ProfileModel.empty();

  final List<ActivityLogModel> _activityLogs = [];
  List<ActivityLogModel> get activityLogs => List.unmodifiable(_activityLogs);

  List<AlarmModel> get alarms => List.unmodifiable(_alarms);
  List<ScheduleModel> get schedules => List.unmodifiable(_schedules);
  ProfileModel get profile => _profile;

  void addActivityLog(String rawLog) {
    final now = DateTime.now();

    final date = "${now.year}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}";
    final time = "${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}";

    // 안전 처리
    final safeLog = (rawLog.isEmpty || rawLog.trim().length < 2)
        ? "알 수 없는 명령을 수행했습니다. (원본: '$rawLog')"
        : rawLog;

    // 아이콘 매핑
    // 아이콘 매핑 확장
    IconData icon;
    if (safeLog.contains("이동") || safeLog.contains("앞으로") || safeLog.contains("전진")) {
      icon = Icons.directions_walk;
    } else if (safeLog.contains("회전") || safeLog.contains("돌아")) {
      icon = Icons.autorenew;
    } else if (safeLog.contains("정지") || safeLog.contains("멈춰")) {
      icon = Icons.stop_circle;
    } else if (safeLog.contains("알람")) {
      icon = Icons.notifications;
    } else if (safeLog.contains("긴급") || safeLog.contains("도와")) {
      icon = Icons.priority_high;
    } else if (safeLog.contains("핸드폰") || safeLog.contains("전화") || safeLog.contains("폰")) {
      icon = Icons.phone_android;
    } else if (safeLog.contains("음악") || safeLog.contains("소리") || safeLog.contains("볼륨")) {
      icon = Icons.volume_up;
    } else if (safeLog.contains("조명") || safeLog.contains("밝기") || safeLog.contains("불")) {
      icon = Icons.light_mode;
    } else {
      icon = Icons.info_outline;
    }


    final log = ActivityLogModel(
      date: date,
      time: time,
      message: safeLog,
      icon: icon,
    );

    _activityLogs.insert(0, log);
    notifyListeners();
  }



  void addAlarm(AlarmModel alarm) {
    _alarms.add(alarm);
    notifyListeners();
  }

  void removeAlarm(String id) {
    _alarms.removeWhere((alarm) => alarm.id == id);
    notifyListeners();
  }

  void addSchedule(ScheduleModel schedule) {
    _schedules.add(schedule);
    notifyListeners();
  }

  void removeSchedule(String id) {
    _schedules.removeWhere((schedule) => schedule.id == id);
    notifyListeners();
  }

  void updateProfile(ProfileModel profile) {
    _profile = profile;
    notifyListeners();
  }

  void clearAll() {
    _alarms.clear();
    _schedules.clear();
    _activityLogs.clear();
    _profile = ProfileModel.empty();
    notifyListeners();
  }
}
