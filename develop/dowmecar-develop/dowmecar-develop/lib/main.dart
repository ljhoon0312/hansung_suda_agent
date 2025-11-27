import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'activitypage.dart';
import 'faceCall.dart';
import 'addSchedule.dart';
import 'addAlarm.dart';
import 'login.dart';
import 'profile.dart';
import 'weeklyreport.dart';
import 'hardwareInfo.dart';
import 'models.dart';
import 'app_state.dart';

class ActivityItem {
  final DateTime timestamp;
  final String type;   // 'move', 'alarm', 'find'
  final String title;  // 예: "이동 활동"
  final String detail; // 예: "거실에서 주방으로 이동"

  ActivityItem({
    required this.timestamp,
    required this.type,
    required this.title,
    required this.detail,
  });
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const DoWooMiCaApp(),
    ),
  );
}

// Responsive utility class
class Responsive {
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Responsive width (percentage of screen width)
  static double wp(BuildContext context, double percentage) {
    return width(context) * percentage / 100;
  }

  // Responsive height (percentage of screen height)
  static double hp(BuildContext context,  double percentage) {
    return height(context) * percentage / 100;
  }

  // Responsive font size
  static double sp(BuildContext context, double size) {
    return size * width(context) / 375; // 375 is base width (iPhone SE)
  }
}

class DoWooMiCaApp extends StatelessWidget {
  const DoWooMiCaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '도우미카',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF87CEEB), // Sky Blue
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF87CEEB),
          primary: const Color(0xFF87CEEB),
          secondary: const Color(0xFFFDD835), // Yellow
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1; // Start with main page

  final List<Widget> _pages = [
    const InfoPage(),
    const HomePage(),
    const OptionsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          left: Responsive.wp(context, 5),
          right: Responsive.wp(context, 5),
          bottom: Responsive.wp(context, 5),
          top: Responsive.wp(context, 0),
        ),
        height: Responsive.hp(context, 9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Responsive.wp(context, 8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: Responsive.wp(context, 5),
              offset: Offset(0, Responsive.hp(context, 0.6)),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Responsive.wp(context, 8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, 0, Icons.person, Responsive.sp(context, 35), isImage: false),
              _buildNavItemWithImage(context, 1, 'assets/car_icon.png', Responsive.sp(context, 35)),
              _buildNavItem(context, 2, Icons.menu, Responsive.sp(context, 35), isImage: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, double size, {required bool isImage}) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _currentIndex = index;
            });
          },
          splashColor: const Color(0xFF87CEEB).withOpacity(0.3),
          highlightColor: const Color(0xFF87CEEB).withOpacity(0.1),
          borderRadius: BorderRadius.circular(Responsive.wp(context, 8)),
          child: Center(
            child: Icon(
              icon,
              size: size,
              color: isSelected ? const Color(0xFF87CEEB) : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItemWithImage(BuildContext context, int index, String imagePath, double size) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _currentIndex = index;
            });
          },
          splashColor: const Color(0xFF87CEEB).withOpacity(0.3),
          highlightColor: const Color(0xFF87CEEB).withOpacity(0.1),
          borderRadius: BorderRadius.circular(Responsive.wp(context, 8)),
          child: Center(
            child: Image.asset(
              imagePath,
              width: size,
              height: size,
              color: isSelected ? null : Colors.grey,
              colorBlendMode: isSelected ? null : BlendMode.srcIn,
              errorBuilder: (context, error, stackTrace) {
                // 이미지 로드 실패 시 기본 아이콘 표시
                return Icon(
                  Icons.directions_car,
                  size: size,
                  color: isSelected ? const Color(0xFF87CEEB) : Colors.grey,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Info Page
class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Container(
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
                children: [
                  SizedBox(height: Responsive.hp(context, 2)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: Responsive.wp(context, 2)),
                      child: Row(
                        children: [
                          Text(
                            '도우',
                            style: TextStyle(
                              fontSize: Responsive.sp(context, 32.2),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFA8D8EA),
                            ),
                          ),
                          Text(
                            '미카',
                            style: TextStyle(
                              fontSize: Responsive.sp(context, 32.2),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFDD835),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.hp(context, 4)),

                  // User Info Card
                  Container(
                    padding: EdgeInsets.all(Responsive.wp(context, 7)),
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
                    child: appState.profile.isEmpty
                        ? Column(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: Responsive.sp(context, 80),
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: Responsive.hp(context, 2)),
                        Text(
                          '프로필을 설정하세요',
                          style: TextStyle(
                            fontSize: Responsive.sp(context, 18),
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: Responsive.hp(context, 1)),
                        Text(
                          '설정 탭에서 프로필 정보를 입력할 수 있습니다',
                          style: TextStyle(
                            fontSize: Responsive.sp(context, 14),
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                        : Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              appState.profile.name,
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 20),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E3A5F),
                              ),
                            ),
                            SizedBox(width: Responsive.wp(context, 2)),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Responsive.wp(context, 3),
                                vertical: Responsive.hp(context, 0.5),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(Responsive.wp(context, 3)),
                              ),
                              child: Text(
                                appState.profile.relationship,
                                style: TextStyle(
                                  fontSize: Responsive.sp(context, 12),
                                  color: const Color(0xFF1E3A5F),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Responsive.hp(context, 3)),

                        // Avatar
                        Container(
                          width: Responsive.wp(context, 30),
                          height: Responsive.wp(context, 30),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: appState.profile.imagePath != null
                                ? Image.asset(
                              appState.profile.imagePath!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: Responsive.sp(context, 60),
                                  color: Colors.grey,
                                );
                              },
                            )
                                : Icon(
                              Icons.person,
                              size: Responsive.sp(context, 60),
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        SizedBox(height: Responsive.hp(context, 3)),

                        // User Details
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.wp(context, 5),
                            vertical: Responsive.hp(context, 1.5),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF9C4),
                            borderRadius: BorderRadius.circular(Responsive.wp(context, 4)),
                          ),
                          child: Text(
                            '나이  |  ${appState.profile.age}세',
                            style: TextStyle(
                              fontSize: Responsive.sp(context, 14),
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1E3A5F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Responsive.hp(context, 4)),

                  // Today's Schedule
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '오늘의 일정',
                      style: TextStyle(
                        fontSize: Responsive.sp(context, 18),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E3A5F),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.hp(context, 1.5)),

                  // 실제 일정 목록 표시
                  if (appState.schedules.isEmpty && appState.alarms.isEmpty)
                    Container(
                      padding: EdgeInsets.all(Responsive.wp(context, 5)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Responsive.wp(context, 4)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: Responsive.wp(context, 2.5),
                            offset: Offset(0, Responsive.hp(context, 0.25)),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '등록된 일정이 없습니다',
                          style: TextStyle(
                            fontSize: Responsive.sp(context, 14),
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    )
                  else
                    Column(
                      children: [
                        // 일정 표시
                        ...appState.schedules.map((schedule) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: Responsive.hp(context, 1)),
                            child: _buildScheduleItem(
                              context,
                              icon: schedule.icon,
                              title: schedule.title,
                              time: '${schedule.date}, ${schedule.time}',
                              color: schedule.iconColor,
                            ),
                          );
                        }),
                        // 알람 표시
                        ...appState.alarms.map((alarm) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: Responsive.hp(context, 1)),
                            child: _buildScheduleItem(
                              context,
                              icon: Icons.alarm,
                              title: alarm.title,
                              time: '${alarm.getTimeString()} - ${alarm.getRepeatDaysString()}',
                              color: const Color(0xFFFDD835),
                            ),
                          );
                        }),
                      ],
                    ),

                  SizedBox(height: Responsive.hp(context, 2)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildScheduleItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String time,
        required Color color,
      }) {
    return Container(
      padding: EdgeInsets.all(Responsive.wp(context, 4)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.wp(context, 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: Responsive.wp(context, 2.5),
            offset: Offset(0, Responsive.hp(context, 0.25)),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.wp(context, 2.5)),
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A5F),
              borderRadius: BorderRadius.circular(Responsive.wp(context, 2.5)),
            ),
            child: Icon(icon, color: Colors.white, size: Responsive.sp(context, 24)),
          ),
          SizedBox(width: Responsive.wp(context, 4)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.sp(context, 16),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E3A5F),
                  ),
                ),
                if (time.isNotEmpty)
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
          Icon(Icons.chevron_right, color: Colors.grey[400], size: Responsive.sp(context, 20)),
          SizedBox(width: Responsive.wp(context, 1.5)),
          Container(
            width: Responsive.wp(context, 3),
            height: Responsive.wp(context, 3),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
              padding: EdgeInsets.only(
                left: Responsive.wp(context, 5),
                right: Responsive.wp(context, 5),
                top: Responsive.wp(context, 5),
                bottom: Responsive.hp(context, 15), // 네비게이션 바 공간 확보
              ),
              child: Column(
                children: [
                  SizedBox(height: Responsive.hp(context, 2)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: Responsive.wp(context, 2)),
                      child: Row(
                        children: [
                          Text(
                            '도우',
                            style: TextStyle(
                              fontSize: Responsive.sp(context, 32.2),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFA8D8EA),
                            ),
                          ),
                          Text(
                            '미카',
                            style: TextStyle(
                              fontSize: Responsive.sp(context, 32.2),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFDD835),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.hp(context, 4)),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: Responsive.wp(context, 4),
                    mainAxisSpacing: Responsive.hp(context, 2),
                    childAspectRatio: 1.0,
                    children: [
                      _buildFeatureButton(context, '일정 추가', Icons.calendar_today, onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddSchedulePage(),
                          ),
                        );
                      }),
                      _buildFeatureButton(context, '알림 추가', Icons.notification_important, onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddAlarmPage(),
                          ),
                        );
                      }),
                      _buildFeatureButton(context, '주간 활동 리포트', Icons.bar_chart, onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const WeeklyReportPage()),
                        );
                      }),
                      _buildFeatureButton(context, '영상 통화', Icons.phone, onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FaceCallPage(),
                          ),
                        );
                      }),
                      _buildFeatureButton(context, '활동 로그', Icons.list_alt, onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ActivityPage(),
                          ),
                        );
                      }),
                      _buildFeatureButton(context, '하드웨어 정보', Icons.settings_input_component, onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HardwareInfoPage(),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // 하단 페이드 아웃 그라데이션 오버레이
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: IgnorePointer(
            child: Container(
              height: Responsive.hp(context, 25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.95),
                  ],
                  stops: const [0.0, 0.8, 1.0],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureButton(BuildContext context, String title, IconData icon, {VoidCallback? onTap}) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Responsive.wp(context, 5)),
          onTap: onTap ?? () {},
          child: Padding(
            padding: EdgeInsets.all(Responsive.wp(context, 5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(Responsive.wp(context, 4)),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(Responsive.wp(context, 4)),
                  ),
                  child: Icon(
                    icon,
                    size: Responsive.sp(context, 40),
                    color: const Color(0xFF87CEEB),
                  ),
                ),
                SizedBox(height: Responsive.hp(context, 1.5)),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.sp(context, 16),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E3A5F),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Options Page
class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            children: [
              SizedBox(height: Responsive.hp(context, 2)),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: Responsive.wp(context, 2)),
                  child: Text(
                    '설정',
                    style: TextStyle(
                      fontSize: Responsive.sp(context, 28),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E3A5F),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Responsive.hp(context, 4)),

              _buildOptionItem(
                context,
                icon: Icons.person,
                title: '프로필 설정',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileSettingsPage(),
                    ),
                  );
                },
              ),
              SizedBox(height: Responsive.hp(context, 1)),
              _buildOptionItem(
                context,
                icon: Icons.notifications,
                title: '알림 설정',
                onTap: () {},
              ),
              SizedBox(height: Responsive.hp(context, 1)),
              _buildOptionItem(
                context,
                icon: Icons.lock,
                title: '개인정보 보호',
                onTap: () {},
              ),
              SizedBox(height: Responsive.hp(context, 1)),
              _buildOptionItem(
                context,
                icon: Icons.language,
                title: '언어 설정',
                onTap: () {},
              ),
              SizedBox(height: Responsive.hp(context, 1)),
              _buildOptionItem(
                context,
                icon: Icons.help_outline,
                title: '도움말',
                onTap: () {},
              ),
              SizedBox(height: Responsive.hp(context, 1)),
              _buildOptionItem(
                context,
                icon: Icons.description,
                title: '라이센스',
                onTap: () {},
              ),
              SizedBox(height: Responsive.hp(context, 1)),
              _buildOptionItem(
                context,
                icon: Icons.info_outline,
                title: '앱 정보',
                onTap: () {},
              ),
              SizedBox(height: Responsive.hp(context, 3)),
              _buildLogoutButton(context),
              SizedBox(height: Responsive.hp(context, 2)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Responsive.wp(context, 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: Responsive.wp(context, 2.5),
            offset: Offset(0, Responsive.hp(context, 0.25)),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Responsive.wp(context, 4)),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(Responsive.wp(context, 5)),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(Responsive.wp(context, 2.5)),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(Responsive.wp(context, 2.5)),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF87CEEB),
                    size: Responsive.sp(context, 24),
                  ),
                ),
                SizedBox(width: Responsive.wp(context, 4)),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: Responsive.sp(context, 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E3A5F),
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                  size: Responsive.sp(context, 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red[400]!,
            Colors.red[600]!,
          ],
        ),
        borderRadius: BorderRadius.circular(Responsive.wp(context, 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: Responsive.wp(context, 4),
            offset: Offset(0, Responsive.hp(context, 0.6)),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Responsive.wp(context, 4)),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Responsive.hp(context, 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: Responsive.sp(context, 24),
                ),
                SizedBox(width: Responsive.wp(context, 2.5)),
                Text(
                  '로그아웃',
                  style: TextStyle(
                    fontSize: Responsive.sp(context, 16),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}