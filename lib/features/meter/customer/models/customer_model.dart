class CustomerModel {
  final int idPelanggan;
  final String nama;
  final String alamat;
  final String distrik;
  final String status;
  final double? latitude;
  final double? longitude;

  CustomerModel({
    required this.idPelanggan,
    required this.nama,
    required this.alamat,
    required this.distrik,
    required this.status,
    this.latitude,
    this.longitude,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      idPelanggan: json['id_pelanggan'],
      nama: json['nama'],
      alamat: json['alamat'] ?? '-',
      distrik: json['distrik']?['nama'] ?? '-',
      status: json['status'] ?? 'BELUM TERBACA', 
      latitude: json['latitude'] != null ? double.parse(json['latitude'].toString()) : null,
      longitude: json['longitude'] != null ? double.parse(json['longitude'].toString()) : null,
    );
  }
}
