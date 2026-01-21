import 'package:flutter/material.dart';
import '../../../core/widgets/custom_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 3,
        title: const Text(
          'SPLASH ONE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Selamat Datang!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text('Input data baca meter pelanggan'),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CustomCard(
                  title: 'Pelanggan Terdaftar',
                  count: 1200,
                  color: Colors.blueAccent,
                  icon: Icons.people,
                ),
              ),
              const SizedBox(width: 8),

              Expanded(
                child: CustomCard(
                  title: 'Meter Terbaca',
                  count: 850,
                  color: Colors.green,
                  icon: Icons.water_damage,
                ),
              ),
              const SizedBox(width: 8),

              Expanded(
                child: CustomCard(
                  title: 'Belum Terbaca',
                  count: 350,
                  color: Colors.red,
                  icon: Icons.receipt_long,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Text(
            'Mulai Input Baca Meter',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          GestureDetector(
            onTap: () {},
            child: CustomCard(
              title: 'Pilih Distrik',
              count: 9,
              color: Colors.orange,
              icon: Icons.map,
            ),
          ),

          const SizedBox(height: 12),

          GestureDetector(
            onTap: () {},
            child: CustomCard(
              title: 'Daftar Pelanggan',
              count: 1200,
              color: Colors.blueGrey,
              icon: Icons.list,
            ),
          ),
        ],
      ),
    );
  }
}
