import 'package:deliciousdal/common/component/custom_text_form_field.dart';
import 'package:deliciousdal/common/layout/default_layout.dart';
import 'package:deliciousdal/user/view/login_screen.dart';
import 'package:flutter/material.dart';

import '../../common/const/colors.dart';
import '../../common/const/data.dart';

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
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                Form(
                  key: this.formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        onChanged: (String value) {
                          username = value;
                        },
                        hintText: '이름',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '필수 입력사항입니다.';
                          } else {
                            if (value!.length < 2) {
                              return '2 글자 이상이야 합니다.';
                            }
                            if (value!.length > 10) {
                              return '10 글자 이하야 합니다.';
                            }

                            if (RegExp(r'[0-9|$@$!%*#?~^<>,.&+=-`(){}\[\]/]')
                                .hasMatch(value)) {
                              return '한글과 영어만 입력가능합니다.';
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        onChanged: (String value) {
                          nickname = value;
                        },
                        hintText: '닉네임',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '필수 입력사항입니다.';
                          } else {
                            if (value.length < 1 || value.length > 10) {
                              return '10 글자 이하로 입력해주세요.';
                            }
                            if (RegExp(r'[$@$!%*#?~^<>,.&+=-`(){}\[\]/]')
                                .hasMatch(value)) {
                              return '특수문자는 입력할 수 없습니다.';
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        onChanged: (String value) {
                          uid = value;
                        },
                        hintText: '이메일',
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
                      SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        onChanged: (String value) {
                          password = value;
                        },
                        hintText: '비밀번호',
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
                      SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        onChanged: (String value) {
                          passwordCk = value;
                        },
                        hintText: '비밀번호 확인',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '필수 입력사항입니다.';
                          } else {
                            if (password != passwordCk) {
                              return '비밀번호와 다릅니다';
                            }
                            if (value.length < 8 || value.length > 15) {
                              return '8자 이상 15자 이내로 입력하세요.';
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        onChanged: (String value) {
                          birth = value;
                        },
                        hintText: '생년월일 (8자리 숫자)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '필수 입력사항입니다.';
                          } else {
                            if (RegExp(
                                    r'[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ$@$!%*#?~^<>,.&+=-`(){}\[\]/]')
                                .hasMatch(value)) {
                              return '숫자만 입력가능합니다.';
                            }
                            if (value.length != 8) {
                              return '8자리를 입력해야합니다.';
                            }
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        onChanged: (String value) {
                          phone = value;
                        },
                        hintText: '전화번호(11자리 숫자)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '필수 입력사항입니다.';
                          } else {
                            if (RegExp(
                                    //$@$!%*#?~^<>,.&+=-
                                    r'[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ|$@$!%*#?~^<>,.&+=-`(){}\[\]/]')
                                .hasMatch(value)) {
                              return '숫자만 입력가능합니다.';
                            }
                            if (value.length != 11) {
                              return '11자리를 입력해야합니다.';
                            }
                          }
                        },
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            if (this.formkey.currentState!.validate()) {
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
                            }
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
