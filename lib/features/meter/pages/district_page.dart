import 'package:flutter/material.dart';

class DistrictPage extends StatelessWidget {
  const DistrictPage({super.key});

  @override
  Widget build(BuildContext context) {
    final districts = [
      {'name': 'Distrik A', 'customers': 120},
      {'name': 'Distrik B', 'customers': 98},
      {'name': 'Distrik C', 'customers': 75},
      {'name': 'Distrik D', 'customers': 150},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        elevation: 3,
        title: const Text(
          'Daftar Distrik',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: districts.length,
        itemBuilder: (context, index) {
          final district = districts[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.map, color: Colors.blueAccent),
              title: Text(
                district['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${district['customers']} pelanggan'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, '/customer', arguments: district);
              },
            ),
          );
        },
      ),
    );
  }
}
