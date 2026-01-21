import 'package:flutter/material.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final customers = [
      {'name': 'Pelanggan 1', 'address': 'Jl. Merpati No. 10'},
      {'name': 'Pelanggan 2', 'address': 'Jl. Kenari No. 5'},
      {'name': 'Pelanggan 3', 'address': 'Jl. Cendrawasih No. 8'},
      {'name': 'Pelanggan 4', 'address': 'Jl. Rajawali No. 12'},
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
          'Daftar Pelanggan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.map, color: Colors.blueAccent),
              title: Text(
                customer['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(customer['address'] as String),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, '/detail', arguments: customer);
              },
            ),
          );
        },
      ),
    );
  }
}
