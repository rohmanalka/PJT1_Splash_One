import 'package:flutter/material.dart';
import '../models/customer_history_model.dart';
import '../services/customer_history_service.dart';
import '../../../../core/widgets/custom_appbar.dart';

class CustomerHistoryPage extends StatelessWidget {
  const CustomerHistoryPage({super.key});

  String monthText(String bulan) {
    final parts = bulan.split('-');
    final year = parts[0];
    final month = int.parse(parts[1]);

    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${months[month - 1]} $year';
  }

  @override
  Widget build(BuildContext context) {
    final int idPelanggan = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Riwayat Pemakaian'),
      body: FutureBuilder<List<CustomerHistoryModel>>(
        future: CustomerHistoryService.fetchHistory(idPelanggan),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(child: Text('Belum ada riwayat'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = data[index];
              return ListTile(
                tileColor: Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: const Icon(Icons.calendar_month),
                title: Text(monthText(item.bulan)),
                subtitle: Text('Pemakaian: ${item.volume} m³'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/customer/history/detail',
                    arguments: {
                      'idPelanggan': idPelanggan,
                      'bulan': item.bulan,
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
