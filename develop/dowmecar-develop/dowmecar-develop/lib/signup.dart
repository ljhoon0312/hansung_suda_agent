import 'package:flutter/material.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
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
                    SizedBox(height: _hp(context, 6)),

                    // 로고 이미지
                    Image.asset(
                      'assets/car_icon.png',
                      width: _wp(context, 30),
                      height: _wp(context, 30),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.directions_car,
                          size: _sp(context, 50),
                          color: const Color(0xFF87CEEB),
                        );
                      },
                    ),

                    SizedBox(height: _hp(context, 2)),

                    // 앱 이름
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '도우',
                          style: TextStyle(
                            fontSize: _sp(context, 28),
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFA8D8EA), // 채도 낮춘 부드러운 블루
                          ),
                        ),
                        Text(
                          '미카',
                          style: TextStyle(
                            fontSize: _sp(context, 28),
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFDD835), // 연노랑
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: _hp(context, 1)),

                    // 회원가입 타이틀
                    Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: _sp(context, 20),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E3A5F),
                      ),
                    ),

                    SizedBox(height: _hp(context, 4)),

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
                          labelText: '비밀번호',
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

                    // 패스워드 확인 입력란
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
                        controller: _passwordConfirmController,
                        obscureText: _obscurePasswordConfirm,
                        decoration: InputDecoration(
                          labelText: '비밀번호 확인',
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
                              _obscurePasswordConfirm
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey[600],
                              size: _sp(context, 24),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePasswordConfirm = !_obscurePasswordConfirm;
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

                    // 로그인 페이지로 돌아가기 텍스트
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          '이미 계정이 있으신가요? 로그인',
                          style: TextStyle(
                            fontSize: _sp(context, 13),
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

              // 하단 회원가입 버튼 (네비게이션 바와 동일한 위치 및 크기)
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
                        // 회원가입 버튼 클릭 시 로그인 화면으로 이동
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      splashColor: Colors.white.withOpacity(0.3),
                      highlightColor: Colors.white.withOpacity(0.1),
                      child: Center(
                        child: Text(
                          '회원가입',
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