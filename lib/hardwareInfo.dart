import 'package:flutter/material.dart';

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

class HardwareInfoPage extends StatelessWidget {
  const HardwareInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 샘플 데이터
    final int batteryPercentage = 75;
    final String releaseDate = '2024년 3월 15일';
    final String lastChargeTime = '2024년 11월 19일 오전 9:30';
    final String estimatedBatteryTime = '약 6시간 30분';

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
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Responsive.wp(context, 5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 뒤로가기 버튼
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: Responsive.sp(context, 24),
                        color: const Color(0xFF1E3A5F),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: Responsive.wp(context, 2)),
                    Text(
                      '하드웨어 정보',
                      style: TextStyle(
                        fontSize: Responsive.sp(context, 24),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E3A5F),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.hp(context, 3)),

                // 차량 이미지 카드
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Responsive.wp(context, 6)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Responsive.wp(context, 6)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: Responsive.wp(context, 5),
                        offset: Offset(0, Responsive.hp(context, 0.6)),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        '도우미카',
                        style: TextStyle(
                          fontSize: Responsive.sp(context, 20),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E3A5F),
                        ),
                      ),
                      SizedBox(height: Responsive.hp(context, 2)),
                      Container(
                        width: Responsive.wp(context, 40),
                        height: Responsive.wp(context, 40),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(Responsive.wp(context, 4)),
                        ),
                        child: Image.asset(
                          'assets/car_icon.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.directions_car,
                              size: Responsive.sp(context, 80),
                              color: const Color(0xFF87CEEB),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Responsive.hp(context, 3)),

                // 배터리 잔량 카드
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Responsive.wp(context, 5)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Responsive.wp(context, 5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: Responsive.wp(context, 5),
                        offset: Offset(0, Responsive.hp(context, 0.6)),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.battery_charging_full,
                            color: const Color(0xFF87CEEB),
                            size: Responsive.sp(context, 24),
                          ),
                          SizedBox(width: Responsive.wp(context, 2)),
                          Text(
                            '배터리 잔량',
                            style: TextStyle(
                              fontSize: Responsive.sp(context, 18),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E3A5F),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.hp(context, 2)),

                      // 배터리 퍼센트 표시
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$batteryPercentage%',
                            style: TextStyle(
                              fontSize: Responsive.sp(context, 32),
                              fontWeight: FontWeight.bold,
                              color: _getBatteryColor(batteryPercentage),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Responsive.wp(context, 3),
                              vertical: Responsive.hp(context, 0.8),
                            ),
                            decoration: BoxDecoration(
                              color: _getBatteryColor(batteryPercentage).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(Responsive.wp(context, 3)),
                            ),
                            child: Text(
                              _getBatteryStatus(batteryPercentage),
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 14),
                                fontWeight: FontWeight.w600,
                                color: _getBatteryColor(batteryPercentage),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.hp(context, 1.5)),

                      // 배터리 바
                      Container(
                        width: double.infinity,
                        height: Responsive.hp(context, 3),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(Responsive.wp(context, 3)),
                        ),
                        child: Stack(
                          children: [
                            FractionallySizedBox(
                              widthFactor: batteryPercentage / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      _getBatteryColor(batteryPercentage),
                                      _getBatteryColor(batteryPercentage).withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(Responsive.wp(context, 3)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Responsive.hp(context, 2)),

                // 출고일 카드
                _buildInfoCard(
                  context,
                  icon: Icons.event,
                  title: '출고일',
                  value: releaseDate,
                  iconColor: const Color(0xFF87CEEB),
                ),

                SizedBox(height: Responsive.hp(context, 2)),

                // 마지막 충전 시간 카드
                _buildInfoCard(
                  context,
                  icon: Icons.power,
                  title: '마지막 충전 시간',
                  value: lastChargeTime,
                  iconColor: const Color(0xFFFDD835),
                ),

                SizedBox(height: Responsive.hp(context, 2)),

                // 예상 배터리 시간 카드
                _buildInfoCard(
                  context,
                  icon: Icons.timer,
                  title: '예상 배터리 시간',
                  value: estimatedBatteryTime,
                  iconColor: const Color(0xFF66BB6A),
                ),

                SizedBox(height: Responsive.hp(context, 3)),

                // 추가 정보 섹션
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Responsive.wp(context, 5)),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9C4).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(Responsive.wp(context, 5)),
                    border: Border.all(
                      color: const Color(0xFFFDD835).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: const Color(0xFF1E3A5F),
                        size: Responsive.sp(context, 20),
                      ),
                      SizedBox(width: Responsive.wp(context, 3)),
                      Expanded(
                        child: Text(
                          '배터리 잔량이 20% 이하일 때는 충전을 권장합니다.',
                          style: TextStyle(
                            fontSize: Responsive.sp(context, 13),
                            color: const Color(0xFF1E3A5F),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Responsive.hp(context, 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String value,
        required Color iconColor,
      }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.wp(context, 5)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.wp(context, 5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: Responsive.wp(context, 5),
            offset: Offset(0, Responsive.hp(context, 0.6)),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.wp(context, 3)),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Responsive.wp(context, 3)),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: Responsive.sp(context, 24),
            ),
          ),
          SizedBox(width: Responsive.wp(context, 4)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.sp(context, 13),
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: Responsive.hp(context, 0.5)),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: Responsive.sp(context, 16),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E3A5F),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getBatteryColor(int percentage) {
    if (percentage > 60) {
      return const Color(0xFF66BB6A); // 초록색
    } else if (percentage > 30) {
      return const Color(0xFFFDD835); // 노란색
    } else {
      return const Color(0xFFEF5350); // 빨간색
    }
  }

  String _getBatteryStatus(int percentage) {
    if (percentage > 60) {
      return '정상';
    } else if (percentage > 30) {
      return '보통';
    } else {
      return '충전 필요';
    }
  }
}