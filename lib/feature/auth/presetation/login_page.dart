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
    return PaddingX(
      number: 14,
      child: Column(
        children: [
          Container(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
              controller: emailController,
            ),
          ),

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
