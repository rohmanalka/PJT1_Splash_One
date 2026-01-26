import 'package:flutter/material.dart';
import '../models/distrik_model.dart';
import '../services/distrik_service.dart';
import 'customer_page.dart';

class DistrictPage extends StatelessWidget {
  final int? parentId;
  final String title;

  const DistrictPage({super.key, this.parentId, this.title = 'Daftar Distrik'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        elevation: 3,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<DistrikModel>>(
        future: DistrikService.getDistrik(parentId: parentId),
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
