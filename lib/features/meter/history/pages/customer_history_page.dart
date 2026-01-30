import 'package:flutter/material.dart';
import '../models/customer_history_model.dart';
import '../services/customer_history_service.dart';
import '../../../../core/widgets/custom_appbar.dart';

class CustomerHistoryPage extends StatefulWidget {
  const CustomerHistoryPage({super.key});

  @override
  State<CustomerHistoryPage> createState() => _CustomerHistoryPageState();
}

class _CustomerHistoryPageState extends State<CustomerHistoryPage> {
  final TextEditingController searchController = TextEditingController();

  List<CustomerHistoryModel> allData = [];
  List<CustomerHistoryModel> filteredData = [];

  bool isLoaded = false;

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

  void applySearch() {
    final keyword = searchController.text.toLowerCase();

    setState(() {
      filteredData = allData.where((item) {
        final bulanRaw = item.bulan.toLowerCase();
        final bulanText = monthText(item.bulan).toLowerCase();

        return bulanRaw.contains(keyword) || bulanText.contains(keyword);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int idPelanggan = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Riwayat Pemakaian'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (_) => applySearch(),
              decoration: InputDecoration(
                hintText: 'Cari bulan atau tahun...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          searchController.clear();
                          applySearch();
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blueAccent,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder<List<CustomerHistoryModel>>(
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

              if (!isLoaded) {
                allData = snapshot.data!;
                filteredData = allData;
                isLoaded = true;
              }

              if (filteredData.isEmpty) {
                return const Center(child: Text('Tidak ada data'));
              }

              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredData.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = filteredData[index];

                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        leading: const Icon(
                          Icons.calendar_month,
                          color: Colors.blueAccent,
                        ),
                        title: Text(
                          monthText(item.bulan),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
