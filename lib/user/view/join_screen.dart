import 'dart:convert';

import 'package:deliciousdal/common/component/custom_text_form_field.dart';
import 'package:deliciousdal/common/layout/default_layout.dart';
import 'package:deliciousdal/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/const/colors.dart';
import '../../common/const/data.dart';
import '../../common/view/root_tab.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  String username = '';
  String nickname = '';
  String uid = '';
  String password = '';
  String passwordCk = '';
  String phone = '';
  String birth = '';
  String Ckpass = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
      child: SingleChildScrollView(
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  onChanged: (String value) {
                    username = value;
                  },
                  hintText: '이름',
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  onChanged: (String value) {
                    nickname = value;
                  },
                  hintText: '닉네임',
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  onChanged: (String value) {
                    uid = value;
                  },
                  hintText: '아이디',
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  onChanged: (String value) {
                    password = value;
                  },
                  hintText: '비밀번호',
                  obscureText: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  onChanged: (String value) {
                    passwordCk = value;
                    if (passwordCk != password) {
                      Ckpass = '비밀번호가 다릅니다';
                    }
                  },
                  hintText: '비밀번호 확인',
                  obscureText: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  onChanged: (String value) {
                    birth = value;
                  },
                  hintText: '생년월일 (8글자)',
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  onChanged: (String value) {
                    phone = value;
                  },
                  hintText: '전화번호(11글자)',
                ),
                SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final resp = await client.auth.signUp(
                        email: uid,
                        password: password,
                        data: {
                          'username': username,
                          'nickname': nickname,
                          'uid': uid,
                          'password': password,
                          'birth': birth,
                          'phone': phone,
                        },
                      );

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                        (route) => false,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '모든 항목을 입력해주세요.',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: BODY_TEXT_COLOR,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: Text(
                    '가입완료',
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

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        bottom: 5,
      ),
      child: Text(
        '회원가입',
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
