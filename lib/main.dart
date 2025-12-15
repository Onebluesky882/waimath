import 'package:flutter/material.dart';
import 'package:waimath/app_router.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://mpehlixteekstdrcdeds.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wZWhsaXh0ZWVrc3RkcmNkZWRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ5MjA5NDksImV4cCI6MjA4MDQ5Njk0OX0.Ke2dvgTavT3Bz7DJs4LtuA5vkKAjkdDn1BFztRsA_u8',
  );
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      debugShowCheckedModeBanner: false,
    );
  }
}
