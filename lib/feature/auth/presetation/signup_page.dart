import 'package:flutter/material.dart';
import 'package:waimath/common/padding_xy.dart';
import 'package:waimath/widget/auth_screen/login_form.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  void login() {
    print(emailController.text);
    print(passwordController.text);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PaddingXy(
      x: 14,
      child: Column(
        children: [
          Align(
            alignment: .centerLeft,
            child: Text(
              'email',
              style: TextStyle(fontWeight: FontWeight.w500),
              textAlign: .start,
            ),
          ),
          LoginForm(controller: emailController, hintText: 'Email'),
          LoginForm(
            controller: passwordController,
            hintText: "Password",
            obscureText: true,
          ),

          SizedBox(height: 10),
          ElevatedButton(onPressed: login, child: Text('login')),
        ],
      ),
    );
  }
} 