class DistrictModel {
  final int id;
  final String nama;
  final String tingkatan;
  final int? parentId;

  DistrictModel({
    required this.id,
    required this.nama,
    required this.tingkatan,
    this.parentId,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id_m_distrik'],
      nama: json['nama'],
      tingkatan: json['tingkatan'],
      parentId: json['id_induk'],
    );
  }
}
