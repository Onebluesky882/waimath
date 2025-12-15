import 'package:flutter/material.dart';
import 'package:waimath/common/padding_xy.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(emailController);
    return PaddingXy(
      child: Column(
        children: [
          PaddingXy(
            x: 10,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              controller: emailController,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              void login() {
                print('$emailController');
              }
            },
            child: Text('login'),
          ),
        ],
      ),
    );
  }
}
