import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/customer_service.dart';
import '../../../../core/widgets/custom_appbar.dart';

class DetailCustomerPage extends StatelessWidget {
  const DetailCustomerPage({super.key});

  Future<void> openGoogleMaps(double lat, double lng) async {
    final uri = Uri.parse('geo:$lat,$lng?q=$lat,$lng');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final idPelanggan = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Detil Pelanggan',
        backgroundColor: Colors.blueAccent,
        elevation: 3,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: CustomerService.getDetail(idPelanggan),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Data tidak ditemukan'));
          }

          final c = snapshot.data!;
          final double? latitude = c['latitude'] != null
              ? double.tryParse(c['latitude'].toString())
              : null;

          final double? longitude = c['longitude'] != null
              ? double.tryParse(c['longitude'].toString())
              : null;

          final meterTerakhir = c['meter_terakhir'];
          final meterText = meterTerakhir != null
              ? '${meterTerakhir['volume']} m³'
              : '-';

          final bool sudahTerbaca = c['status'] == 'SUDAH TERBACA';

          return ListView(
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
                    c['nama'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('ID Pelanggan: ${c['id_pelanggan']}'),
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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '$latitude, $longitude',
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: latitude is double && longitude is double
                              ? () => openGoogleMaps(latitude, longitude)
                              : null,
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
                    _infoTile(Icons.home, 'Alamat', c['alamat']),
                    const Divider(height: 1),
                    _infoTile(Icons.map, 'Distrik', c['distrik']),
                    const Divider(height: 1),
                    _infoTile(Icons.speed, 'Meter Terakhir', meterText),
                    const Divider(height: 1),
                    _infoTile(
                      Icons.info,
                      'Status Bulan Ini',
                      c['status'],
                      valueColor: sudahTerbaca ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigator.pushNamed(
                        //   context,
                        //   '/history-customer',
                        //   arguments: idPelanggan,
                        // );
                      },
                      icon: const Icon(Icons.history, color: Colors.white),
                      label: const Text(
                        'Lihat Riwayat',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/input',
                          arguments: idPelanggan,
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text(
                        'Input Baca Meter',
                        style: TextStyle(
                          fontSize: 14,
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
            ],
          );
        },
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
