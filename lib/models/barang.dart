class Barang {
  final String id;
  final String nama;
  final String kategori;
  final int stok;
  final double hargaSatuan;

  Barang({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.stok,
    required this.hargaSatuan,
  });

  double get totalHarga => stok * hargaSatuan;
} 

