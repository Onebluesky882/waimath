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
          TextLoginField(controller: emailController, hintText: 'Email'),
          TextLoginField(
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

class TextLoginField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const TextLoginField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: 'Email',
        border: OutlineInputBorder(borderRadius: .circular(18)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.blue, // border color when focused
            width: 2,
          ),
        ),
      ),
    );
  }
}
