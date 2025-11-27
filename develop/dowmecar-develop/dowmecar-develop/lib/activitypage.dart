import 'package:flutter/material.dart';
import 'main.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  // 날짜별 데이터
  final Map<String, List<Map<String, dynamic>>> activityData = const {
    "2025년 11월 16일 (일)": [
      {
        "icon": Icons.directions_walk,
        "title": "이동 활동",
        "detail": "안방에서 주방으로 이동",
        "time": "오전 09:20",
      },
      {
        "icon": Icons.phone_android,
        "title": "핸드폰 찾기",
        "detail": "기기를 호출했습니다",
        "time": "오전 09:10",
      },
      {
        "icon": Icons.directions_walk,
        "title": "이동 활동",
        "detail": "거실에서 안방으로 이동",
        "time": "오전 08:55",
      },
      {
        "icon": Icons.directions_walk,
        "title": "이동 활동",
        "detail": "주방에서 거실로 이동",
        "time": "오전 08:35",
      },
      {
        "icon": Icons.notifications,
        "title": "일정 알림",
        "detail": "혈압약 복용 일정 안내",
        "time": "오전 08:00",
      },
      {
        "icon": Icons.phone_android,
        "title": "핸드폰 찾기",
        "detail": "기기를 호출했습니다",
        "time": "오전 07:00",
      },
    ],

    "2025년 11월 15일 (토)": [
      {
        "icon": Icons.phone_android,
        "title": "핸드폰 찾기",
        "detail": "기기를 호출했습니다",
        "time": "오후 03:32",
      },
      {
        "icon": Icons.directions_walk,
        "title": "이동 활동",
        "detail": "안방에서 거실으로 이동",
        "time": "오후 01:10",
      },
      {
        "icon": Icons.directions_walk,
        "title": "이동 활동",
        "detail": "주방에서 안방으로 이동",
        "time": "오후 12:40",
      },
      {
        "icon": Icons.notifications,
        "title": "일정 알림",
        "detail": "정기 병원 진료 일정",
        "time": "오전 10:00",
      },
      {
        "icon": Icons.phone_android,
        "title": "핸드폰 찾기",
        "detail": "기기를 호출했습니다",
        "time": "오전 09:30",
      },
    ],

    "2025년 11월 14일 (금)": [
      {
        "icon": Icons.directions_walk,
        "title": "이동 활동",
        "detail": "안방에서 거실로 이동",
        "time": "오후 03:10",
      },
      {
        "icon": Icons.directions_walk,
        "title": "이동 활동",
        "detail": "거실에서 주방으로 이동",
        "time": "오후 02:45",
      },
      {
        "icon": Icons.notifications,
        "title": "일정 알림",
        "detail": "혈압약 복용 일정 안내",
        "time": "오전 09:00",
      },
    ],

    "2025년 11월 13일 (목)": [
      {
        "icon": Icons.directions_walk,
        "title": "이동 활동",
        "detail": "주방에서 거실로 이동",
        "time": "오후 02:20",
      },
      {
        "icon": Icons.directions_walk,
        "title": "이동 활동",
        "detail": "거실에서 안방으로 이동",
        "time": "오후 01:55",
      },
      {
        "icon": Icons.notifications,
        "title": "일정 알림",
        "detail": "정기 병원 진료 일정",
        "time": "오전 10:00",
      },
    ],

    "2025년 11월 12일 (수)": [
      {
        "icon": Icons.directions_walk,
        "title": "이동 활동",
        "detail": "거실에서 주방으로 이동",
        "time": "오후 03:10",
      },
      {
        "icon": Icons.directions_walk,
        "title": "이동 활동",
        "detail": "주방에서 거실으로 이동",
        "time": "오후 01:12",
      },
    ],

    "2025년 11월 11일 (화)": [
      {
        "icon": Icons.phone_android,
        "title": "핸드폰 찾기",
        "detail": "기기를 호출했습니다",
        "time": "오전 08:55",
      },
      {
        "icon": Icons.directions_walk,
        "title": "이동 활동",
        "detail": "주방에서 안방으로 이동",
        "time": "오전 09:20",
      },
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F2F9), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.wp(context, 5),
              vertical: Responsive.hp(context, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: Responsive.hp(context, 2)),

                // 날짜 출력
                for (final entry in activityData.entries) ...[
                  _buildDateLabel(context, entry.key),

                  // 날짜 활동 리스트
                  for (int i = 0; i < entry.value.length; i++)
                    _buildTimelineItem(
                      context,
                      icon: entry.value[i]['icon'],
                      title: entry.value[i]['title'],
                      detail: entry.value[i]['detail'],
                      time: entry.value[i]['time'],
                      isLast: i == entry.value.length - 1,
                    ),

                  SizedBox(height: Responsive.hp(context, 3)),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 상단 헤더
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Responsive.hp(context, 2)),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_back,
              color: const Color(0xFF1E3A5F),
              size: Responsive.sp(context, 28),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Center(
              child: Text(
                '활동 로그',
                style: TextStyle(
                  fontSize: Responsive.sp(context, 24),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E3A5F),
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // 날짜 구분
  Widget _buildDateLabel(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.hp(context, 1)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: Responsive.sp(context, 15),
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1E3A5F),
        ),
      ),
    );
  }

  // 타임라인
  Widget _buildTimelineItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String detail,
        required String time,
        required bool isLast,
      }) {
    Color dotColor;
    if (title == "이동 활동") {
      dotColor = const Color(0xFF6BB6DA);
    } else if (title == "일정 알림") {
      dotColor = const Color(0xFFFDD835);
    } else if (title == "핸드폰 찾기") {
      dotColor = const Color(0xFF4CAF50);
    } else {
      dotColor = const Color(0xFF87CEEB);
    }

    double dotSize = Responsive.wp(context, 2.4);
    double paddingV = Responsive.hp(context, 1.3);
    double cardHeight = paddingV * 2 + Responsive.hp(context, 5);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 도트,라인
        Column(
          children: [
            Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: cardHeight + Responsive.hp(context, 1),
                color: Colors.grey.withOpacity(0.35),
              ),
          ],
        ),

        SizedBox(width: Responsive.wp(context, 4)),

        // 카드
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: paddingV,
              horizontal: Responsive.wp(context, 3),
            ),
            margin: EdgeInsets.only(bottom: Responsive.hp(context, 1.2)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.15)),
            ),
            child: Row(
              children: [
                Icon(icon, color: dotColor, size: Responsive.sp(context, 22)),
                SizedBox(width: Responsive.wp(context, 3)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: Responsive.sp(context, 15),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E3A5F),
                        ),
                      ),
                      SizedBox(height: Responsive.hp(context, 0.3)),
                      Text(
                        detail,
                        style: TextStyle(
                          fontSize: Responsive.sp(context, 13),
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: Responsive.sp(context, 12),
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
