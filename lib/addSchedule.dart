import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'models.dart';
import 'package:intl/intl.dart';

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

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  
  IconData _selectedIcon = Icons.event;
  Color _selectedIconColor = const Color(0xFF87CEEB);
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // 선택 가능한 아이콘 리스트
  final List<Map<String, dynamic>> _iconOptions = [
    {'icon': Icons.event, 'label': '일정'},
    {'icon': Icons.medical_services, 'label': '병원'},
    {'icon': Icons.medication, 'label': '알약'},
    {'icon': Icons.calendar_today, 'label': '달력'},
    {'icon': Icons.local_hospital, 'label': '의료'},
    {'icon': Icons.favorite, 'label': '건강'},
    {'icon': Icons.restaurant, 'label': '식사'},
    {'icon': Icons.fitness_center, 'label': '운동'},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
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
                      '일정 추가',
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

                      // 일정 추가 폼 영역
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
                            // 아이콘 선택
                            Text(
                              '일정 아이콘',
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 16),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E3A5F),
                              ),
                            ),
                            SizedBox(height: Responsive.hp(context, 1.5)),

                            // 선택된 아이콘 표시
                            GestureDetector(
                              onTap: _showIconPicker,
                              child: Container(
                                padding: EdgeInsets.all(Responsive.wp(context, 4)),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE3F2FD),
                                  borderRadius: BorderRadius.circular(Responsive.wp(context, 3)),
                                  border: Border.all(
                                    color: const Color(0xFF87CEEB),
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(Responsive.wp(context, 2)),
                                      decoration: BoxDecoration(
                                        color: _selectedIconColor,
                                        borderRadius: BorderRadius.circular(Responsive.wp(context, 2)),
                                      ),
                                      child: Icon(
                                        _selectedIcon,
                                        color: Colors.white,
                                        size: Responsive.sp(context, 30),
                                      ),
                                    ),
                                    SizedBox(width: Responsive.wp(context, 3)),
                                    Text(
                                      '아이콘을 선택하세요',
                                      style: TextStyle(
                                        fontSize: Responsive.sp(context, 15),
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey[400],
                                      size: Responsive.sp(context, 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: Responsive.hp(context, 3)),

                            // 일정 제목
                            Text(
                              '일정 제목',
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
                                hintText: '일정 제목을 입력하세요',
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

                            // 날짜
                            Text(
                              '날짜',
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 16),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E3A5F),
                              ),
                            ),
                            SizedBox(height: Responsive.hp(context, 1)),
                            TextField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                hintText: '날짜를 선택하세요',
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
                                suffixIcon: const Icon(
                                  Icons.calendar_today,
                                  color: Color(0xFF87CEEB),
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: Color(0xFF87CEEB),
                                          onPrimary: Colors.white,
                                          surface: Colors.white,
                                          onSurface: Color(0xFF1E3A5F),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (date != null) {
                                  setState(() {
                                    _selectedDate = date;
                                    _dateController.text = DateFormat('yyyy년 M월 d일').format(date);
                                  });
                                }
                              },
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 15),
                                color: const Color(0xFF1E3A5F),
                              ),
                            ),
                            SizedBox(height: Responsive.hp(context, 3)),

                            // 시간
                            Text(
                              '시간',
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 16),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E3A5F),
                              ),
                            ),
                            SizedBox(height: Responsive.hp(context, 1)),
                            TextField(
                              controller: _timeController,
                              decoration: InputDecoration(
                                hintText: '시간을 선택하세요',
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
                                suffixIcon: const Icon(
                                  Icons.access_time,
                                  color: Color(0xFF87CEEB),
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: Color(0xFF87CEEB),
                                          onPrimary: Colors.white,
                                          surface: Colors.white,
                                          onSurface: Color(0xFF1E3A5F),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (time != null) {
                                  setState(() {
                                    _selectedTime = time;
                                    _timeController.text = time.format(context);
                                  });
                                }
                              },
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 15),
                                color: const Color(0xFF1E3A5F),
                              ),
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
                        _saveSchedule();
                      },
                      splashColor: Colors.white.withOpacity(0.3),
                      highlightColor: Colors.white.withOpacity(0.1),
                      child: Center(
                        child: Text(
                          '일정 저장',
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

  void _showIconPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Responsive.wp(context, 6)),
              topRight: Radius.circular(Responsive.wp(context, 6)),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: Responsive.hp(context, 2)),
              Container(
                width: Responsive.wp(context, 12),
                height: Responsive.hp(context, 0.6),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(Responsive.wp(context, 1)),
                ),
              ),
              SizedBox(height: Responsive.hp(context, 2)),
              Text(
                '아이콘 선택',
                style: TextStyle(
                  fontSize: Responsive.sp(context, 20),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E3A5F),
                ),
              ),
              SizedBox(height: Responsive.hp(context, 2)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.wp(context, 5)),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: Responsive.wp(context, 3),
                    mainAxisSpacing: Responsive.hp(context, 2),
                  ),
                  itemCount: _iconOptions.length,
                  itemBuilder: (context, index) {
                    final option = _iconOptions[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIcon = option['icon'];
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(Responsive.wp(context, 3)),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(Responsive.wp(context, 3)),
                        ),
                        child: Icon(
                          option['icon'],
                          color: const Color(0xFF87CEEB),
                          size: Responsive.sp(context, 32),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: Responsive.hp(context, 3)),
            ],
          ),
        );
      },
    );
  }

  void _saveSchedule() {
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '일정 제목을 입력해주세요',
            style: TextStyle(fontSize: Responsive.sp(context, 14)),
          ),
          backgroundColor: Colors.red[400],
        ),
      );
      return;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '날짜를 선택해주세요',
            style: TextStyle(fontSize: Responsive.sp(context, 14)),
          ),
          backgroundColor: Colors.red[400],
        ),
      );
      return;
    }

    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '시간을 선택해주세요',
            style: TextStyle(fontSize: Responsive.sp(context, 14)),
          ),
          backgroundColor: Colors.red[400],
        ),
      );
      return;
    }

    // 일정 생성 및 저장
    final schedule = ScheduleModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      icon: _selectedIcon,
      iconColor: _selectedIconColor,
      title: title,
      date: DateFormat('M월 d일').format(_selectedDate!),
      time: _selectedTime!.format(context),
    );

    Provider.of<AppState>(context, listen: false).addSchedule(schedule);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '일정이 저장되었습니다',
          style: TextStyle(fontSize: Responsive.sp(context, 14)),
        ),
        backgroundColor: const Color(0xFF87CEEB),
      ),
    );

    Navigator.pop(context);
  }
}
