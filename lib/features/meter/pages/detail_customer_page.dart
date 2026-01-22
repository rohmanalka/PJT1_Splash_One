import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailCustomerPage extends StatelessWidget {
  const DetailCustomerPage({super.key});

  Future<void> openGoogleMaps(double lat, double lng) async {
    final uri = Uri.parse('geo:$lat,$lng?q=$lat,$lng');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final customer = {
      'name': 'Herlambang',
      'customer_id': 'PLG-00123',
      'address': 'Jl. Surabaya No.2A',
      'district': 'Distrik A',
      'last_meter': 1250,
      'status': 'Belum Terbaca',
      'latitude': -7.965512,
      'longitude': 112.618865,
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Detail Pelanggan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                customer['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(customer['customer_id'] as String),
            ),
          ),
          const SizedBox(height: 12),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lokasi Pelanggan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.blueAccent),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${customer['latitude']}, ${customer['longitude']}',
                          style: const TextStyle(fontFamily: 'monospace'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        openGoogleMaps(
                          customer['latitude'] as double,
                          customer['longitude'] as double,
                        );
                      },
                      icon: const Icon(Icons.map, color: Colors.white),
                      label: const Text(
                        'Buka Navigasi Google Maps',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _infoTile(Icons.home, 'Alamat', customer['address'] as String),
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
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/input');
              },
              icon: const Icon(Icons.edit, color: Colors.white),
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
      subtitle: Text(value, style: TextStyle(color: valueColor)),
    );
  }
}
