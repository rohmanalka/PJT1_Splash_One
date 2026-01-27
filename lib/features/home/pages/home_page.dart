import 'package:flutter/material.dart';
import '../services/home_service.dart';
import '../widgets/progress_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/menu_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF0D47A1);
    const secondary = Color(0xFF42A5F5);
    const bgColor = Color(0xFFF5F7FA);

    return Scaffold(
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'SPLASH ONE',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: HomeService.getDashboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Gagal memuat dashboard'));
          }

          final data = snapshot.data!;
          final total = data['pelanggan'] ?? 0;
          final terbaca = data['terbaca'] ?? 0;
          final belum = data['belum_terbaca'] ?? 0;
          final progressBulanan = total == 0 ? 0.0 : terbaca / total;

          return RefreshIndicator(
            onRefresh: () async => HomeService.getDashboard(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 110, 20, 30),
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
                          'Halo, Petugas Lapangan 👋',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Laporan Bulan Ini',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ProgressCard(
                          value: progressBulanan,
                          subtitle: '$terbaca dari $total pelanggan selesai',
                        ),
                      ],
                    ),
                  ),

                  Transform.translate(
                    offset: const Offset(0, -10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              title: 'Belum',
                              value: belum,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              title: 'Sukses',
                              value: terbaca,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: StatCard(
                              title: 'Total',
                              value: total,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Menu Utama',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        GridView.count(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.3,
                          children: [
                            MenuCard(
                              title: 'Pilih Distrik',
                              icon: Icons.map_rounded,
                              onTap: () {
                                Navigator.pushNamed(context, '/district');
                              },
                            ),
                            MenuCard(
                              title: 'Pelanggan',
                              icon: Icons.list_alt_rounded,
                              onTap: () {
                                Navigator.pushNamed(context, '/customer');
                              },
                            ),
                            MenuCard(
                              title: 'Riwayat',
                              icon: Icons.history,
                              onTap: () {
                                Navigator.pushNamed(context, '/history');
                              },
                            ),
                            MenuCard(
                              title: 'Keluar',
                              icon: Icons.logout,
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/login',
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
