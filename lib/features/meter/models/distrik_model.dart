class DistrikModel {
  final int id;
  final String nama;
  final String tingkatan;
  final int? parentId;

  DistrikModel({
    required this.id,
    required this.nama,
    required this.tingkatan,
    this.parentId,
  });

  factory DistrikModel.fromJson(Map<String, dynamic> json) {
    return DistrikModel(
      id: json['id_m_distrik'],
      nama: json['nama'],
      tingkatan: json['tingkatan'],
      parentId: json['id_induk'],
    );
  }
}
