class CustomerHistoryModel {
  final String bulan;
  final double volume;
  final String fotoUrl;

  CustomerHistoryModel({
    required this.bulan,
    required this.volume,
    required this.fotoUrl,
  });

  factory CustomerHistoryModel.fromJson(Map<String, dynamic> json) {
    return CustomerHistoryModel(
      bulan: json['bulan'],
      volume: double.parse(json['volume'].toString()),
      fotoUrl: json['foto_url'],
    );
  }
}
