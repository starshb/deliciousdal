import 'package:deliciousdal/common/const/colors.dart';
import 'package:deliciousdal/common/const/data.dart';
import 'package:deliciousdal/common/layout/default_layout.dart';
import 'package:deliciousdal/fingerprint/screens/auth_screen.dart';
import 'package:deliciousdal/pay/pay_main.dart';
import 'package:deliciousdal/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:deliciousdal/common/const/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<String> getMy() async {
    final user = client.auth.currentUser;
    final name = user!.userMetadata!['nickname'];
    // print("user는 ${user?.userMetadata?['username']}");
    return name;
  }

  @override
  Widget build(BuildContext context) {
    getMy();
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder(
              future: getMy(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Text(
                      '${snapshot.data} 님',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LocalAuthScreen(),
                  ),
                );
              },
              child: Text(
                '보안인증',
                style: TextStyle(
                  color: PRIMARY_COLOR,
                ),
              ),
            ),
            // OutlinedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (_) => MyApp(),
            //       ),
            //     );
            //   },
            //   child: Text(
            //     '결제정보',
            //     style: TextStyle(
            //       color: PRIMARY_COLOR,
            //     ),
            //   ),
            // ),
            ElevatedButton(
              onPressed: () async {
                await client.auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(),
                    ),
                    (route) => false);
              },
              child: Text('로그아웃'),
              style: ElevatedButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
