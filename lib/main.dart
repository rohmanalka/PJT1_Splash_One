import 'package:flutter/material.dart';
import 'features/auth/pages/login_page.dart';
import 'features/home/pages/home_page.dart';
import 'features/meter/customer/pages/customer_page.dart';
import 'features/meter/district/pages/district_page.dart';
import 'features/meter/customer/pages/detail_customer_page.dart';
import 'features/meter/customer/pages/form_input_page.dart';
import 'features/meter/history/pages/user_history_page.dart';
import 'features/meter/history/pages/customer_history_page.dart';
import 'features/meter/history/pages/customer_history_detail_page.dart';

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
        '/history': (context) => const UserHistoryPage(),
        '/customer/history': (_) => const CustomerHistoryPage(),
        '/customer/history/detail': (_) => const CustomerHistoryDetailPage(),
      },
    );
  }
}
