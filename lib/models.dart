import 'package:flutter/material.dart';

// 알람 모델
class AlarmModel {
  final String id;
  final String title;
  final TimeOfDay time;
  final List<bool> selectedDays;
  final bool isEnabled;

  AlarmModel({
    required this.id,
    required this.title,
    required this.time,
    required this.selectedDays,
    this.isEnabled = true,
  });

  String getTimeString() {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String getRepeatDaysString() {
    final dayLabels = ['월', '화', '수', '목', '금', '토', '일'];
    final selectedDayNames = <String>[];

    for (int i = 0; i < selectedDays.length; i++) {
      if (selectedDays[i]) {
        selectedDayNames.add(dayLabels[i]);
      }
    }

    if (selectedDayNames.isEmpty) {
      return '반복 없음';
    } else if (selectedDayNames.length == 7) {
      return '매일';
    } else {
      return selectedDayNames.join(', ');
    }
  }
}

// 일정 모델
class ScheduleModel {
  final String id;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String date;
  final String time;

  ScheduleModel({
    required this.id,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.time,
  });

  String getDateString() {
    return date;
  }

  String getTimeString() {
    return time;
  }
}

// 프로필 모델
class ProfileModel {
  final String name;
  final String age;
  final String relationship;
  final String? imagePath;

  ProfileModel({
    required this.name,
    required this.age,
    required this.relationship,
    this.imagePath,
  });

  // 빈 프로필 생성자
  factory ProfileModel.empty() {
    return ProfileModel(
      name: '',
      age: '',
      relationship: '',
    );
  }

  // 프로필이 비어있는지 확인
  bool get isEmpty => name.isEmpty || age.isEmpty || relationship.isEmpty;
}

// 활동 로그 모델
class ActivityLogModel {
  final String date;     // yyyy-MM-dd
  final String time;     // HH:mm
  final String message;  // 로그 메시지
  final IconData icon;   // 아이콘

  ActivityLogModel({
    required this.date,
    required this.time,
    required this.message,
    required this.icon,
  });
}
