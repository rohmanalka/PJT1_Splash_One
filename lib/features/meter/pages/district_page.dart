import 'package:flutter/material.dart';
import '../models/district_model.dart';
import '../services/district_service.dart';
import 'customer_page.dart';
import '../../../core/widgets/custom_appbar.dart';

class DistrictPage extends StatelessWidget {
  final int? parentId;
  final String title;

  const DistrictPage({super.key, this.parentId, this.title = 'Daftar Distrik'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Daftar Distrik',
        backgroundColor: Colors.blueAccent,
        elevation: 3,
      ),
      body: FutureBuilder<List<DistrictModel>>(
        future: DistrictService.getDistrik(parentId: parentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada distrik'));
          }

          final districts = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: districts.length,
            itemBuilder: (context, index) {
              final d = districts[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.map, color: Colors.blueAccent),
                  title: Text(
                    d.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(d.tingkatan),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    if (d.tingkatan == 'Desa') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CustomerPage(idDistrik: d.id),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DistrictPage(parentId: d.id, title: d.nama),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
