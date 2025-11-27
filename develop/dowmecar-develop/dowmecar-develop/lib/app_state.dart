import 'package:flutter/material.dart';
import 'models.dart';

class AppState extends ChangeNotifier {
  final List<AlarmModel> _alarms = [];
  final List<ScheduleModel> _schedules = [];
  ProfileModel _profile = ProfileModel.empty();

  List<AlarmModel> get alarms => List.unmodifiable(_alarms);
  List<ScheduleModel> get schedules => List.unmodifiable(_schedules);
  ProfileModel get profile => _profile;

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
    _profile = ProfileModel.empty();
    notifyListeners();
  }
}