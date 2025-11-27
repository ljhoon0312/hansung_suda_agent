import 'package:flutter/material.dart';
import 'main.dart';

class WeeklyReportPage extends StatefulWidget {
  const WeeklyReportPage({super.key});

  @override
  State<WeeklyReportPage> createState() => _WeeklyReportPageState();
}

class _WeeklyReportPageState extends State<WeeklyReportPage> {
  int weekOffset = 0;

  // 월요일
  DateTime get startOfWeek {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return monday.add(Duration(days: weekOffset * 7));
  }

  // 일요일
  DateTime get endOfWeek => startOfWeek.add(const Duration(days: 6));

  // 주차 계산
  int getKoreanMonthlyWeekNumber(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    DateTime firstWeekStart = firstDay;

    while (firstWeekStart.weekday != DateTime.monday) {
      firstWeekStart = firstWeekStart.add(const Duration(days: 1));
      if (firstWeekStart.month != date.month) break;
    }

    if (firstWeekStart.month != date.month) {
      firstWeekStart = firstDay;
    }

    final diff = date.difference(firstWeekStart).inDays;
    if (diff < 0) return 1;
    return (diff ~/ 7) + 1;
  }

  String get weekLabel {
    final weekNum = getKoreanMonthlyWeekNumber(startOfWeek);
    return "${startOfWeek.year}년 ${startOfWeek.month}월 ${weekNum}주차";
  }

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
                _buildWeekNavigator(),
                SizedBox(height: Responsive.hp(context, 2)),
                _buildWeeklyGraph(),
                SizedBox(height: Responsive.hp(context, 4)),

                _buildSectionTitle("기능별 활동 요약"),
                SizedBox(height: Responsive.hp(context, 2)),

                _buildActivityCard(
                  title: '이동 활동',
                  count: 25,
                  detail: '거실 10회 · 안방 9회 · 주방 6회',
                  icon: Icons.directions_walk,
                ),
                SizedBox(height: Responsive.hp(context, 2)),

                _buildActivityCard(
                  title: '알림 설정',
                  count: 9,
                  detail: '복약 알림 6회 · 병원 일정 3회',
                  icon: Icons.notifications,
                ),
                SizedBox(height: Responsive.hp(context, 2)),

                _buildActivityCard(
                  title: '핸드폰 찾기',
                  count: 2,
                  detail: '11월 6일 1회 · 11월 8일 1회',
                  icon: Icons.phone_android,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 상단 헤더
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: Responsive.hp(context, 2)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.arrow_back,
                color: const Color(0xFF1E3A5F),
                size: Responsive.sp(context, 28),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Text(
            '주간 활동 리포트',
            style: TextStyle(
              fontSize: Responsive.sp(context, 24),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E3A5F),
            ),
          ),
        ],
      ),
    );
  }

  // 주차 네비게이터
  Widget _buildWeekNavigator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => setState(() => weekOffset--),
          child: const Icon(Icons.chevron_left,
              size: 28, color: Color(0xFF6B7B8C)),
        ),
        Text(
          weekLabel,
          style: TextStyle(
            fontSize: Responsive.sp(context, 15),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E3A5F),
          ),
        ),
        Opacity(
          opacity: weekOffset == 0 ? 0.3 : 1,
          child: GestureDetector(
            onTap: weekOffset == 0 ? null : () => setState(() => weekOffset++),
            child: const Icon(Icons.chevron_right,
                size: 28, color: Color(0xFF6B7B8C)),
          ),
        ),
      ],
    );
  }

  // 요일별 막대그래프
  Widget _buildWeeklyGraph() {
    final weeklyData = {"월": 3, "화": 6, "수": 8, "목": 5, "금": 7, "토": 4, "일": 3};
    final maxValue = weeklyData.values.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: EdgeInsets.all(Responsive.wp(context, 5)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Text(
            "${startOfWeek.month}월 ${startOfWeek.day}일 ~ "
                "${endOfWeek.month}월 ${endOfWeek.day}일",
            style: TextStyle(
              fontSize: Responsive.sp(context, 13),
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: Responsive.hp(context, 1)),
          Container(height: 1, color: Colors.grey.withOpacity(0.12)),
          SizedBox(height: Responsive.hp(context, 1)),

          ...weeklyData.entries.map((e) {
            final ratio = e.value / maxValue;

            return Padding(
              padding: EdgeInsets.symmetric(vertical: Responsive.hp(context, 0.9)),
              child: Row(
                children: [
                  SizedBox(
                    width: Responsive.wp(context, 10),
                    child: Text(
                      e.key,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Responsive.sp(context, 12),
                        color: const Color(0xFF5C6D7A),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.wp(context, 3)),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: Responsive.hp(context, 1.6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7EEF3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: ratio,
                          child: Container(
                            height: Responsive.hp(context, 1.6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF87CEEB),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: Responsive.wp(context, 3)),
                  Text(
                    "${e.value}회",
                    style: TextStyle(
                      fontSize: Responsive.sp(context, 12),
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: Responsive.sp(context, 18),
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1E3A5F),
      ),
    );
  }

  // 활동 카드
  Widget _buildActivityCard({
    required String title,
    required int count,
    required String detail,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(Responsive.wp(context, 4)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.wp(context, 2.5)),
            decoration: BoxDecoration(
              color: const Color(0xFFE9F3F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: Responsive.sp(context, 20),
              color: const Color(0xFF6BB6DA),
            ),
          ),

          SizedBox(width: Responsive.wp(context, 3)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: Responsive.sp(context, 15),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E3A5F),
                      ),
                    ),
                    Text(
                      "$count회",
                      style: TextStyle(
                        fontSize: Responsive.sp(context, 12),
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.hp(context, 0.3)),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: Responsive.sp(context, 12),
                    color: Colors.grey[600],
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
