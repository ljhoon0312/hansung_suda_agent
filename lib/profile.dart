import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'models.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 현재 프로필 정보로 초기화 (비어있지 않은 경우에만)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profile = Provider.of<AppState>(context, listen: false).profile;
      if (!profile.isEmpty) {
        _nameController.text = profile.name;
        _ageController.text = profile.age;
        _relationshipController.text = profile.relationship;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _relationshipController.dispose();
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
                padding: EdgeInsets.all(_wp(context, 5)),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: _sp(context, 28),
                        color: const Color(0xFF1E3A5F),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: _wp(context, 2)),
                    Text(
                      '프로필 설정',
                      style: TextStyle(
                        fontSize: _sp(context, 24),
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
                  padding: EdgeInsets.symmetric(horizontal: _wp(context, 8)),
                  child: Column(
                    children: [
                      SizedBox(height: _hp(context, 3)),

                      // 프로필 이미지
                      Stack(
                        children: [
                          Container(
                            width: _wp(context, 35),
                            height: _wp(context, 35),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: _wp(context, 5),
                                  offset: Offset(0, _hp(context, 0.5)),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Icon(
                                Icons.person,
                                size: _sp(context, 70),
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                _showImagePickerDialog();
                              },
                              child: Container(
                                padding: EdgeInsets.all(_wp(context, 2)),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF87CEEB),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: _wp(context, 2),
                                      offset: Offset(0, _hp(context, 0.2)),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: _sp(context, 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: _hp(context, 5)),

                      // 이름 입력란
                      _buildInputField(
                        controller: _nameController,
                        label: '이름',
                        icon: Icons.person_outline,
                        hint: '이름을 입력하세요',
                      ),

                      SizedBox(height: _hp(context, 2)),

                      // 나이 입력란
                      _buildInputField(
                        controller: _ageController,
                        label: '나이',
                        icon: Icons.cake_outlined,
                        hint: '나이를 입력하세요',
                        keyboardType: TextInputType.number,
                      ),

                      SizedBox(height: _hp(context, 2)),

                      // 관계 입력란
                      _buildInputField(
                        controller: _relationshipController,
                        label: '관계',
                        icon: Icons.family_restroom,
                        hint: '관계를 입력하세요 (예: 엄마, 아빠)',
                      ),

                      SizedBox(height: _hp(context, 20)),
                    ],
                  ),
                ),
              ),

              // 하단 저장 버튼
              Padding(
                padding: EdgeInsets.only(
                  left: _wp(context, 5),
                  right: _wp(context, 5),
                  bottom: _wp(context, 5),
                ),
                child: Container(
                  height: _hp(context, 9),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFF59D),
                        Color(0xFFFFF176),
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
                        _saveProfile();
                      },
                      splashColor: Colors.white.withOpacity(0.3),
                      highlightColor: Colors.white.withOpacity(0.1),
                      child: Center(
                        child: Text(
                          '저장',
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Container(
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
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: _sp(context, 16),
          ),
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: _sp(context, 14),
          ),
          prefixIcon: Icon(
            icon,
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
    );
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '프로필 이미지 선택',
            style: TextStyle(
              fontSize: _sp(context, 18),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E3A5F),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF87CEEB)),
                title: Text(
                  '갤러리에서 선택',
                  style: TextStyle(fontSize: _sp(context, 16)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '이미지 선택 기능은 준비 중입니다',
                        style: TextStyle(fontSize: _sp(context, 14)),
                      ),
                      backgroundColor: const Color(0xFF87CEEB),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF87CEEB)),
                title: Text(
                  '카메라로 촬영',
                  style: TextStyle(fontSize: _sp(context, 16)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '카메라 기능은 준비 중입니다',
                        style: TextStyle(fontSize: _sp(context, 14)),
                      ),
                      backgroundColor: const Color(0xFF87CEEB),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveProfile() {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final relationship = _relationshipController.text.trim();

    if (name.isEmpty || age.isEmpty || relationship.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '모든 항목을 입력해주세요',
            style: TextStyle(fontSize: _sp(context, 14)),
          ),
          backgroundColor: Colors.red[400],
        ),
      );
      return;
    }

    // 프로필 생성 및 저장
    final profile = ProfileModel(
      name: name,
      age: age,
      relationship: relationship,
    );

    Provider.of<AppState>(context, listen: false).updateProfile(profile);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '프로필이 저장되었습니다',
          style: TextStyle(fontSize: _sp(context, 14)),
        ),
        backgroundColor: const Color(0xFF87CEEB),
      ),
    );

    // 저장 후 이전 화면으로 돌아가기
    Navigator.pop(context);
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