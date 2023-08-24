import 'dart:convert';
import 'dart:io';

import 'package:deliciousdal/common/component/custom_snackbar.dart';
import 'package:deliciousdal/common/const/colors.dart';
import 'package:deliciousdal/common/const/data.dart';
import 'package:deliciousdal/common/layout/default_layout.dart';
import 'package:deliciousdal/user/view/join_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/view/root_tab.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String uid = '';
  String password = '';
  late final User? user;
  final formkey = GlobalKey<FormState>();

  Future<String?> userLogin({
    required final String uid,
    required final String password,
  }) async {
    final resp = await client.auth.signInWithPassword(
      email: uid,
      password: password,
    );
    user = resp.user;
    return user?.id;
  }

  @override
  Widget build(BuildContext context) {
    final current = client.auth.currentUser;
    if (current != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => RootTab(),
          ),
          (route) => false);
    }

    final dio = Dio();
    final Session? session = client.auth.currentSession;
    print(session);
    // if (session != null) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(
    //           builder: (_) => RootTab(),
    //         ),
    //         (route) => false);
    //   });
    // }
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        //드래그 했을 때 키보드 내려감
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(
                  height: 16.0,
                ),
                _SubTitle(),
                Image.asset(
                  'assets/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                Form(
                  key: this.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        onChanged: (String value) {
                          uid = value;
                        },
                        hintText: '이메일을 입력해주세요',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '필수 입력사항입니다.';
                          } else {
                            if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return '잘못된 이메일 형식입니다.';
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        onChanged: (String value) {
                          password = value;
                        },
                        hintText: '비밀번호를 입력해주세요',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '필수 입력사항입니다.';
                          } else {
                            if (value.length < 8 || value.length > 15) {
                              return '8자 이상 15자 이내로 입력하세요.';
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (this.formkey.currentState!.validate()) {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Row(
                            //       children: [
                            //         Icon(
                            //           Icons.priority_high_outlined,
                            //           color: Colors.red,
                            //         ),
                            //         Text(
                            //           '아이디와 비밀번호를 확인해주세요.',
                            //           style: TextStyle(
                            //             color: Colors.white,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     backgroundColor: BODY_TEXT_COLOR,
                            //   ),
                            // );

                            try {
                              final resp = await client.auth.signInWithPassword(
                                email: uid,
                                password: password,
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => RootTab(),
                                ),
                                (route) => false,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '아이디나 비밀번호를 다시 한 번 확인해주세요.',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: BODY_TEXT_COLOR,
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PRIMARY_COLOR,
                        ),
                        child: Text(
                          '로그인',
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => JoinScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child: Text(
                          '회원가입',
                        ),
                      ),
                    ],
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
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해 로그인 해주세요!\n오늘도 기다림이 짧은 즐거운 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
