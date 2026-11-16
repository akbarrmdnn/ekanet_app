class Pengajuan{
  final String id;
  final String namaPengaju;
  final String namaBarang;
  final int jumlah;
  final String keterangan;
  String status;

  Pengajuan({
  required this.id,
  required this.namaPengaju,
  required this.namaBarang,
  required this.jumlah,
  required this.keterangan,
  this.status= 'Pending',
 });
}

