import 'package:flutter/material.dart';

class DetailCustomerPage extends StatelessWidget {
  const DetailCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = {
      'name': 'Budi Santoso',
      'customer_id': 'PLG-00123',
      'address': 'Jl. Merdeka No. 10',
      'district': 'Distrik A',
      'last_meter': 1250,
      'status': 'Belum Terbaca',
    };

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
          'Detail Pelanggan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 180,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.room, size: 60, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 12),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                customer['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(customer['customer_id'] as String),
            ),
          ),
          const SizedBox(height: 12),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _infoTile(
                  Icons.location_on,
                  'Alamat',
                  customer['address'] as String,
                ),
                const Divider(height: 1),
                _infoTile(Icons.map, 'Distrik', customer['district'] as String),
                const Divider(height: 1),
                _infoTile(
                  Icons.speed,
                  'Meter Terakhir',
                  customer['last_meter'].toString(),
                ),
                const Divider(height: 1),
                _infoTile(
                  Icons.info,
                  'Status',
                  customer['status'] as String,
                  valueColor: Colors.red,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/input');
              },
              label: const Text(
                'Input Baca Meter',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _infoTile(
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(label),
      subtitle: Text(
        value,
        style: TextStyle(color: valueColor),
      ),
    );
  }
}
