import 'package:flutter/material.dart';
import '../models/pelanggan_model.dart';
import '../services/pelanggan_service.dart';

class CustomerPage extends StatefulWidget {
  final int? idDistrik;

  const CustomerPage({super.key, this.idDistrik});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  late Future<List<PelangganModel>> pelangganFuture;

  @override
  void initState() {
    super.initState();

    if (widget.idDistrik != null) {
      pelangganFuture = PelangganService.getByDistrik(widget.idDistrik!);
    } else {
      pelangganFuture = PelangganService.getAll();
    }
  }

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
        title: const Text(
          'Daftar Pelanggan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<PelangganModel>>(
        future: pelangganFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Tidak ada pelanggan di distrik ini'),
            );
          }

          final customers = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final c = customers[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.blueAccent),
                  title: Text(
                    c.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(c.alamat),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: c.idPelanggan,
                    );
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
