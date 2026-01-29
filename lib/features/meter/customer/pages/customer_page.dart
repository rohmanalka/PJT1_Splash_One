import 'package:flutter/material.dart';
import '../models/customer_model.dart';
import '../services/customer_service.dart';
import '../../../../core/widgets/custom_appbar.dart';

class CustomerPage extends StatefulWidget {
  final int? idDistrik;

  const CustomerPage({super.key, this.idDistrik});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  late Future<List<CustomerModel>> pelangganFuture;
  final TextEditingController searchController = TextEditingController();

  List<CustomerModel> allCustomers = [];
  List<CustomerModel> filteredCustomers = [];
  String selectedStatus = 'SEMUA';

  @override
  void initState() {
    super.initState();

    pelangganFuture = widget.idDistrik != null
        ? CustomerService.getByDistrik(widget.idDistrik!)
        : CustomerService.getAll();
  }

  void _filterCustomer() {
    setState(() {
      filteredCustomers = allCustomers.where((c) {
        final search = searchController.text.toLowerCase();
        final matchSearch =
            c.nama.toLowerCase().contains(search) ||
            c.alamat.toLowerCase().contains(search);

        final matchStatus =
            selectedStatus == 'SEMUA' || c.status == selectedStatus;

        return matchSearch && matchStatus;
      }).toList();
    });
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _filterTile('SEMUA'),
            _filterTile('SUDAH TERBACA'),
            _filterTile('BELUM TERBACA'),
          ],
        );
      },
    );
  }

  Widget _filterTile(String status) {
    return ListTile(
      title: Text(status),
      trailing: selectedStatus == status
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () {
        setState(() {
          selectedStatus = status;
          _filterCustomer();
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Daftar Pelanggan',
        backgroundColor: Colors.blueAccent,
        elevation: 3,
      ),
      body: FutureBuilder<List<CustomerModel>>(
        future: pelangganFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada pelanggan'));
          }

          if (allCustomers.isEmpty) {
            allCustomers = snapshot.data!;
            filteredCustomers = allCustomers;
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (_) => _filterCustomer(),
                        decoration: InputDecoration(
                          hintText: 'Cari nama atau alamat...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    searchController.clear();
                                    _filterCustomer();
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
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.blueAccent,
                      ),
                      onPressed: _showFilterDialog,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: filteredCustomers.isEmpty
                    ? const Center(child: Text('Pelanggan tidak ditemukan'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredCustomers.length,
                        itemBuilder: (context, index) {
                          final c = filteredCustomers[index];

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.person,
                                color: c.status == 'SUDAH TERBACA'
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                              title: Text(
                                c.nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(c.alamat),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: c.status == 'SUDAH TERBACA'
                                          ? Colors.green.shade100
                                          : Colors.red.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      c.status,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: c.status == 'SUDAH TERBACA'
                                            ? Colors.green.shade800
                                            : Colors.red.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
