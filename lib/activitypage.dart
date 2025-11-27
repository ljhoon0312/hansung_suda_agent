import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'models.dart';
import 'main.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final logs = appState.activityLogs;

        // 날짜별 그룹핑
        Map<String, List<ActivityLogModel>> grouped = {};
        for (final log in logs) {
          grouped.putIfAbsent(log.date, () => []);
          grouped[log.date]!.add(log);
        }

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
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.wp(context, 5),
                  vertical: Responsive.hp(context, 1),
                ),
                children: [
                  _buildHeader(context),
                  SizedBox(height: Responsive.hp(context, 2)),

                  // 아무 로그 없을 때
                  if (grouped.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: Responsive.hp(context, 5)),
                        child: Text(
                          "아직 기록된 활동이 없어요.",
                          style: TextStyle(
                            fontSize: Responsive.sp(context, 16),
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),

                  // 날짜 그룹별 출력
                  for (final entry in grouped.entries) ...[
                    _buildDateTitle(context, entry.key),
                    SizedBox(height: Responsive.hp(context, 0.5)),
                    _buildDivider(),

                    for (final log in entry.value)
                      _buildListItem(context, log),

                    _buildDivider(),
                    SizedBox(height: Responsive.hp(context, 2)),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 헤더
  Widget _buildHeader(BuildContext context) {
    return Row(
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
    );
  }

  // 날짜 타이틀
  Widget _buildDateTitle(BuildContext context, String date) {
    return Text(
      date,
      style: TextStyle(
        fontSize: Responsive.sp(context, 18),
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1E3A5F),
      ),
    );
  }

  // 구분선
  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 1,
      color: Colors.black12,
    );
  }

  // 목록
  Widget _buildListItem(BuildContext context, ActivityLogModel log) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.hp(context, 1),
      ),
      child: Row(
        children: [
          // 작은 원형 아이콘
          Container(
            width: Responsive.wp(context, 7),
            height: Responsive.wp(context, 7),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black12),
            ),
            child: Icon(
              log.icon,
              size: Responsive.sp(context, 18),
              color: Color(0xFF6BB6DA),
            ),
          ),

          SizedBox(width: Responsive.wp(context, 4)),

          // 메시지
          Expanded(
            child: Text(
              log.message,
              style: TextStyle(
                fontSize: Responsive.sp(context, 14.5),
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1E3A5F),
              ),
            ),
          ),

          // 시간
          Text(
            log.time,
            style: TextStyle(
              fontSize: Responsive.sp(context, 13),
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
