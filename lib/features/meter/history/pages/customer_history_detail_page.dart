import 'package:flutter/material.dart';
import '../models/customer_history_model.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../services/customer_history_service.dart';

class CustomerHistoryDetailPage extends StatelessWidget {
  const CustomerHistoryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final int idPelanggan = args['idPelanggan'];
    final String bulan = args['bulan'];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Detail Baca Meter'),
      body: FutureBuilder<CustomerHistoryModel>(
        future: CustomerHistoryService.fetchDetail(idPelanggan, bulan),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat detail'));
          }

          final data = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                height: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    data.fotoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.water_drop),
                  title: const Text('Pemakaian'),
                  subtitle: Text(
                    'Pemakaian: ${data.volume.toStringAsFixed(0)} m³',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
