import 'package:flutter/material.dart';
import 'features/auth/pages/login_page.dart';
import 'features/home/pages/home_page.dart';
import 'features/meter/pages/customer_page.dart';
import 'features/meter/pages/district_page.dart';
import 'features/meter/pages/detail_customer_page.dart';
import 'features/meter/pages/form_input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash One',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/customer': (context) => const CustomerPage(),
        '/district': (context) => const DistrictPage(),
        '/detail': (context) => const DetailCustomerPage(),
        '/input': (context) => const FormInputPage(),
      },
    );
  }
}