import 'package:flutter/material.dart';
import '../../../core/storage/app_storage.dart';
import '../../auth/pages/login_page.dart';
import '../widgets/stat_card.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF0D47A1);
    const secondary = Color(0xFF42A5F5);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('SPLASH ONE',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white,),
            tooltip: 'Logout',
            onPressed: () async {
              await AppStorage.clear();

              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 110, 20, 39),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary, secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Halo, Pelanggan',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'Catatan Meter Air',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Transform.translate(
              offset: const Offset(0, -10),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        title: 'Meter Bulan Lalu',
                        value: 1200,
                        color: Colors.orangeAccent
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: StatCard(
                        title: 'Meter Bulan Ini',
                        value: 1300,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            
          ],
        ),
      ),
    );
  }
}
