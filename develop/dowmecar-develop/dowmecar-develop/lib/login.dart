import 'package:flutter/material.dart';
import 'main.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
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
          child: Stack(
            children: [
              // 메인 컨텐츠
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: _wp(context, 8),
                ),
                child: Column(
                  children: [
                    SizedBox(height: _hp(context, 16)), // 12 -> 16으로 증가

                    // 로고 이미지
                    Image.asset(
                      'assets/car_icon.png',
                      width: _wp(context, 50),
                      height: _wp(context, 50),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.directions_car,
                          size: _sp(context, 60),
                          color: const Color(0xFF87CEEB),
                        );
                      },
                    ),

                    SizedBox(height: _hp(context, 3)),

                    // 앱 이름
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '도우',
                          style: TextStyle(
                            fontSize: _sp(context, 32),
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFA8D8EA), // 채도 낮춘 부드러운 블루
                          ),
                        ),
                        Text(
                          '미카',
                          style: TextStyle(
                            fontSize: _sp(context, 32),
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFDD835), // 연노랑
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: _hp(context, 6)),

                    // 아이디 입력란
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(_wp(context, 4)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: _wp(context, 3),
                            offset: Offset(0, _hp(context, 0.3)),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _idController,
                        decoration: InputDecoration(
                          labelText: '아이디',
                          labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: _sp(context, 16),
                          ),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: const Color(0xFF87CEEB),
                            size: _sp(context, 24),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(_wp(context, 4)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: _wp(context, 4),
                            vertical: _hp(context, 2),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: _sp(context, 16),
                          color: const Color(0xFF1E3A5F),
                        ),
                      ),
                    ),

                    SizedBox(height: _hp(context, 2)),

                    // 패스워드 입력란
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(_wp(context, 4)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: _wp(context, 3),
                            offset: Offset(0, _hp(context, 0.3)),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: '패스워드',
                          labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: _sp(context, 16),
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: const Color(0xFF87CEEB),
                            size: _sp(context, 24),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey[600],
                              size: _sp(context, 24),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(_wp(context, 4)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: _wp(context, 4),
                            vertical: _hp(context, 2),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: _sp(context, 16),
                          color: const Color(0xFF1E3A5F),
                        ),
                      ),
                    ),

                    SizedBox(height: _hp(context, 2)),

                    // 회원가입 텍스트
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          );
                        },
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            fontSize: _sp(context, 14),
                            color: const Color(0xFF87CEEB),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: _hp(context, 15)),
                  ],
                ),
              ),

              // 하단 로그인 버튼 (네비게이션 바와 동일한 위치 및 크기)
              Positioned(
                left: _wp(context, 5),
                right: _wp(context, 5),
                bottom: _wp(context, 5),
                child: Container(
                  height: _hp(context, 9),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFF59D), // 더 연한 노랑
                        Color(0xFFFFF176), // 연한 노랑
                      ],
                    ),
                    borderRadius: BorderRadius.circular(_wp(context, 8)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFF59D).withOpacity(0.3),
                        blurRadius: _wp(context, 5),
                        offset: Offset(0, _hp(context, 0.6)),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(_wp(context, 8)),
                      onTap: () {
                        // 로그인 버튼 클릭 시 메인 화면으로 이동
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      },
                      splashColor: Colors.white.withOpacity(0.3),
                      highlightColor: Colors.white.withOpacity(0.1),
                      child: Center(
                        child: Text(
                          '로그인',
                          style: TextStyle(
                            fontSize: _sp(context, 20),
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

  // Responsive helper methods
  double _width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double _height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double _wp(BuildContext context, double percentage) {
    return _width(context) * percentage / 100;
  }

  double _hp(BuildContext context, double percentage) {
    return _height(context) * percentage / 100;
  }

  double _sp(BuildContext context, double size) {
    return size * _width(context) / 375;
  }
}