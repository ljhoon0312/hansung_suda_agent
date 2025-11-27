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

class FaceCallPage extends StatefulWidget {
  const FaceCallPage({super.key});

  @override
  State<FaceCallPage> createState() => _FaceCallPageState();
}

class _FaceCallPageState extends State<FaceCallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A5F),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 바
            Padding(
              padding: EdgeInsets.all(Responsive.wp(context, 4)),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: Responsive.sp(context, 28),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Text(
                      '영상 통화',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Responsive.sp(context, 20),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.wp(context, 12)),
                ],
              ),
            ),

            // 영상 통화 화면 영역
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.videocam,
                      size: Responsive.sp(context, 80),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    SizedBox(height: Responsive.hp(context, 3)),
                    Text(
                      '영상 통화 준비중',
                      style: TextStyle(
                        fontSize: Responsive.sp(context, 24),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          left: Responsive.wp(context, 5),
          right: Responsive.wp(context, 5),
          bottom: Responsive.wp(context, 5),
          top: Responsive.wp(context, 0),
        ),
        height: Responsive.hp(context, 9),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(Responsive.wp(context, 8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
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
              // 마이크 버튼
              _buildControlButton(
                context,
                icon: Icons.mic_off,
              ),
              // 통화 종료 버튼
              _buildControlButton(
                context,
                icon: Icons.call_end,
                isEndCall: true,
              ),
              // 카메라 전환 버튼
              _buildControlButton(
                context,
                icon: Icons.cameraswitch,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton(
      BuildContext context, {
        required IconData icon,
        bool isEndCall = false,
      }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (isEndCall) {
              Navigator.pop(context);
            }
          },
          splashColor: Colors.white.withOpacity(0.3),
          highlightColor: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(Responsive.wp(context, 8)),
          child: Center(
            child: Icon(
              icon,
              size: isEndCall ? Responsive.sp(context, 55) : Responsive.sp(context, 35),
              color: isEndCall ? Colors.red : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}