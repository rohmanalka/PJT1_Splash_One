class PelangganModel {
  final int idPelanggan;
  final String nama;
  final String alamat;
  final String distrik;
  final double latitude;
  final double longitude;

  PelangganModel({
    required this.idPelanggan,
    required this.nama,
    required this.alamat,
    required this.distrik,
    required this.latitude,
    required this.longitude,
  });

  factory PelangganModel.fromJson(Map<String, dynamic> json) {
    return PelangganModel(
      idPelanggan: json['id_pelanggan'],
      nama: json['nama'],
      alamat: json['alamat'],
      distrik: json['distrik'] != null ? json['distrik']['nama'] : '-',
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
    );
  }
}
