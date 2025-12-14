import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waimath/homepage.dart';
import 'package:waimath/login.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(appBar: AppBar(), body: child);
        },
        routes: [
          GoRoute(path: "/", builder: (context, state) => const Homepage()),
          GoRoute(path: "/login", builder: (context, state) => const Login()),
        ],
      ),
    ],
  );
}
