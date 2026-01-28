import 'dart:io';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../widgets/open_camera.dart';
import '../services/input_service.dart';

class FormInputPage extends StatefulWidget {
  const FormInputPage({super.key});

  @override
  State<FormInputPage> createState() => _FormInputPageState();
}

class _FormInputPageState extends State<FormInputPage> {
  final _meterController = TextEditingController();
  final _periodController = TextEditingController();

  String? photoPath;
  DateTime selectedMonth = DateTime.now();
  late int idPelanggan;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    idPelanggan = ModalRoute.of(context)!.settings.arguments as int;
  }

  void _openCamera() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const OpenCamera(),
    );

    if (result != null && mounted) {
      setState(() {
        photoPath = result;
      });
    }
  }

  Future<void> _submit() async {
    if (_isLoading) return;

    if (photoPath == null || _meterController.text.isEmpty) {
      _showMessage('Lengkapi data');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // print('SUBMIT START');
    final errorMessage = await InputService.submitBacaMeter(
      idPelanggan: idPelanggan,
      bulan: selectedMonth,
      volume: int.parse(_meterController.text),
      photoPath: photoPath!,
    );
    // print('SUBMIT END');

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (errorMessage == null) {
      _showMessage('Berhasil simpan');
      Navigator.pop(context, true);
    } else {
      _showMessage(errorMessage);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    _setPeriodText(selectedMonth);
  }

  void _setPeriodText(DateTime date) {
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
    _periodController.text = '${months[date.month - 1]} ${date.year}';
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
          'Input Baca Meter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GestureDetector(
            onTap: _openCamera,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: photoPath == null
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('Ambil Foto Meter'),
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(photoPath!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),

          CustomTextField(
            controller: _meterController,
            label: 'Angka Meter',
            keyboardType: TextInputType.number,
            prefixIcon: const Icon(Icons.speed),
          ),
          const SizedBox(height: 12),

          GestureDetector(
            onTap: () async {
              final picked = await showMonthPicker(
                context: context,
                initialDate: selectedMonth,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );

              if (picked != null) {
                setState(() {
                  selectedMonth = picked;
                  _setPeriodText(picked);
                });
              }
            },
            child: AbsorbPointer(
              child: CustomTextField(
                controller: _periodController,
                label: 'Periode Baca',
                readOnly: true,
                prefixIcon: const Icon(Icons.calendar_month),
              ),
            ),
          ),
          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: _isLoading ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Simpan Baca Meter',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
