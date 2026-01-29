class CustomerModel {
  final int idPelanggan;
  final String nama;
  final String alamat;
  final String distrik;
  final double? latitude;
  final double? longitude;

  CustomerModel({
    required this.idPelanggan,
    required this.nama,
    required this.alamat,
    required this.distrik,
    this.latitude,
    this.longitude,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      idPelanggan: json['id_pelanggan'],
      nama: json['nama'],
      alamat: json['alamat'],
      distrik: json['distrik'] != null ? json['distrik']['nama'] : '-',
      latitude: json['latitude'] != null ? double.parse(json['latitude'].toString()) : null,
      longitude: json['longitude'] != null ? double.parse(json['longitude'].toString()) : null,
    );
  }
}
