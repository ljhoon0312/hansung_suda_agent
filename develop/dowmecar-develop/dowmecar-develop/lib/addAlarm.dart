import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'models.dart';

// Responsive utility class
class Responsive {
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double wp(BuildContext context, double percentage) {
    return width(context) * percentage / 100;
  }

  static double hp(BuildContext context, double percentage) {
    return height(context) * percentage / 100;
  }

  static double sp(BuildContext context, double size) {
    return size * width(context) / 375;
  }
}

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({super.key});

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  final TextEditingController _titleController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final List<bool> _selectedDays = List.generate(7, (_) => false);
  final List<String> _dayLabels = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 상단 헤더
              Padding(
                padding: EdgeInsets.all(Responsive.wp(context, 5)),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: const Color(0xFF1E3A5F),
                        size: Responsive.sp(context, 28),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: Responsive.wp(context, 2)),
                    Text(
                      '알림 추가',
                      style: TextStyle(
                        fontSize: Responsive.sp(context, 24),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E3A5F),
                      ),
                    ),
                  ],
                ),
              ),

              // 스크롤 가능한 컨텐츠
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.wp(context, 5)),
                  child: Column(
                    children: [
                      SizedBox(height: Responsive.hp(context, 2)),

                      // 알림 추가 폼 영역
                      Container(
                        padding: EdgeInsets.all(Responsive.wp(context, 5)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Responsive.wp(context, 5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: Responsive.wp(context, 4),
                              offset: Offset(0, Responsive.hp(context, 0.6)),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 알림 제목
                            Text(
                              '알림 제목',
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 16),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E3A5F),
                              ),
                            ),
                            SizedBox(height: Responsive.hp(context, 1)),
                            TextField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                hintText: '알림 제목을 입력하세요',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: Responsive.sp(context, 14),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Responsive.wp(context, 3)),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Responsive.wp(context, 3)),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Responsive.wp(context, 3)),
                                  borderSide: const BorderSide(color: Color(0xFF87CEEB), width: 2),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: Responsive.wp(context, 4),
                                  vertical: Responsive.hp(context, 1.5),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 15),
                                color: const Color(0xFF1E3A5F),
                              ),
                            ),
                            SizedBox(height: Responsive.hp(context, 3)),

                            // 알림 시간 (시계형)
                            Text(
                              '알림 시간',
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 16),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E3A5F),
                              ),
                            ),
                            SizedBox(height: Responsive.hp(context, 2)),

                            // 시계 디스플레이
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  final TimeOfDay? picked = await showTimePicker(
                                    context: context,
                                    initialTime: _selectedTime,
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: Color(0xFF87CEEB),
                                            onPrimary: Colors.white,
                                            surface: Colors.white,
                                            onSurface: Color(0xFF1E3A5F),
                                          ),
                                          timePickerTheme: TimePickerThemeData(
                                            backgroundColor: Colors.white,
                                            hourMinuteTextColor: const Color(0xFF1E3A5F),
                                            dayPeriodTextColor: MaterialStateColor.resolveWith((states) {
                                              if (states.contains(MaterialState.selected)) {
                                                return Colors.white;
                                              }
                                              return const Color(0xFF1E3A5F);
                                            }),
                                            dayPeriodColor: MaterialStateColor.resolveWith((states) {
                                              if (states.contains(MaterialState.selected)) {
                                                return const Color(0xFF87CEEB);
                                              }
                                              return Colors.grey[200]!;
                                            }),
                                            dialHandColor: const Color(0xFF87CEEB),
                                            dialBackgroundColor: const Color(0xFFE3F2FD),
                                            hourMinuteColor: MaterialStateColor.resolveWith((states) {
                                              if (states.contains(MaterialState.selected)) {
                                                return const Color(0xFF87CEEB);
                                              }
                                              return const Color(0xFFE3F2FD);
                                            }),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      _selectedTime = picked;
                                    });
                                  }
                                },
                                child: Container(
                                  width: Responsive.wp(context, 50),
                                  height: Responsive.wp(context, 50),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFFE3F2FD),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: Responsive.wp(context, 4),
                                        offset: Offset(0, Responsive.hp(context, 0.5)),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: Responsive.sp(context, 40),
                                          color: const Color(0xFF87CEEB),
                                        ),
                                        SizedBox(height: Responsive.hp(context, 1)),
                                        Text(
                                          _selectedTime.format(context),
                                          style: TextStyle(
                                            fontSize: Responsive.sp(context, 32),
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF1E3A5F),
                                          ),
                                        ),
                                        SizedBox(height: Responsive.hp(context, 0.5)),
                                        Text(
                                          '탭하여 변경',
                                          style: TextStyle(
                                            fontSize: Responsive.sp(context, 12),
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: Responsive.hp(context, 3)),

                            // 반복 요일 선택
                            Text(
                              '반복',
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 16),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E3A5F),
                              ),
                            ),
                            SizedBox(height: Responsive.hp(context, 1.5)),

                            // 요일 버튼들
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(7, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedDays[index] = !_selectedDays[index];
                                    });
                                  },
                                  child: Container(
                                    width: Responsive.wp(context, 11),
                                    height: Responsive.wp(context, 11),
                                    decoration: BoxDecoration(
                                      color: _selectedDays[index]
                                          ? const Color(0xFF87CEEB)
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(Responsive.wp(context, 2)),
                                      boxShadow: _selectedDays[index]
                                          ? [
                                        BoxShadow(
                                          color: const Color(0xFF87CEEB).withOpacity(0.4),
                                          blurRadius: Responsive.wp(context, 2),
                                          offset: Offset(0, Responsive.hp(context, 0.2)),
                                        ),
                                      ]
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _dayLabels[index],
                                        style: TextStyle(
                                          fontSize: Responsive.sp(context, 14),
                                          fontWeight: FontWeight.bold,
                                          color: _selectedDays[index]
                                              ? Colors.white
                                              : Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: Responsive.hp(context, 20)),
                    ],
                  ),
                ),
              ),

              // 하단 저장 버튼
              Padding(
                padding: EdgeInsets.only(
                  left: Responsive.wp(context, 5),
                  right: Responsive.wp(context, 5),
                  bottom: Responsive.wp(context, 5),
                ),
                child: Container(
                  height: Responsive.hp(context, 9),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFF59D),
                        Color(0xFFFFF176),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(Responsive.wp(context, 8)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFF59D).withOpacity(0.3),
                        blurRadius: Responsive.wp(context, 5),
                        offset: Offset(0, Responsive.hp(context, 0.6)),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(Responsive.wp(context, 8)),
                      onTap: () {
                        _saveAlarm();
                      },
                      splashColor: Colors.white.withOpacity(0.3),
                      highlightColor: Colors.white.withOpacity(0.1),
                      child: Center(
                        child: Text(
                          '알림 저장',
                          style: TextStyle(
                            fontSize: Responsive.sp(context, 20),
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E3A5F),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveAlarm() {
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '알림 제목을 입력해주세요',
            style: TextStyle(fontSize: Responsive.sp(context, 14)),
          ),
          backgroundColor: Colors.red[400],
        ),
      );
      return;
    }

    // 알람 생성 및 저장
    final alarm = AlarmModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      time: _selectedTime,
      selectedDays: List.from(_selectedDays),
    );

    Provider.of<AppState>(context, listen: false).addAlarm(alarm);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '알림이 저장되었습니다',
          style: TextStyle(fontSize: Responsive.sp(context, 14)),
        ),
        backgroundColor: const Color(0xFF87CEEB),
      ),
    );

    Navigator.pop(context);
  }
}
