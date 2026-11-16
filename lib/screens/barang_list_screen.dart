import 'package:flutter/material.dart';

import '../models/barang.dart';
import 'tambah_barang_screen.dart';
import 'edit_barang_screen.dart';

class BarangListScreen extends StatefulWidget {
  const BarangListScreen({super.key});

  @override
  State<BarangListScreen> createState() => _BarangListScreenState();
}

class _BarangListScreenState extends State<BarangListScreen> {
  //data dummy sementara
  final List<Barang> _semuaBarang = [
    Barang(
      id: '1',
      nama: 'Router Mikrotik RB750',
      kategori: 'Jaringan',
      stok: 15,
      hargaSatuan: 850000,
    ),
    Barang(
      id: '2',
      nama: 'Kabel Fiber Optic 1 Roll',
      kategori: 'Kabel',
      stok: 3,
      hargaSatuan: 2500000,
    ),
    Barang(
      id: '3',
      nama: 'ONT / Modem Huawei',
      kategori: 'Perangkat Klien',
      stok: 45,
      hargaSatuan: 350000,
    ),
    Barang(
      id: '4',
      nama: 'Splicer Fiber Optic',
      kategori: 'Alat Kerja',
      stok: 2,
      hargaSatuan: 15000000,
    ),
    Barang(
      id: '5',
      nama: 'Konektor SC/UPC (100 pcs)',
      kategori: 'Aksesoris',
      stok: 0,
      hargaSatuan: 150000,
    ),
    Barang(
      id: '6',
      nama: 'Access Point TP-Link',
      kategori: 'Jaringan',
      stok: 8,
      hargaSatuan: 450000,
    ),
    Barang(
      id: '7',
      nama: 'Tangga Lipat Fiber',
      kategori: 'Alat Kerja',
      stok: 4,
      hargaSatuan: 1200000,
    ),
    Barang(
      id: '8',
      nama: 'Kabel LAN Cat6 (1 Roll)',
      kategori: 'Kabel',
      stok: 10,
      hargaSatuan: 1800000,
    ),
  ];

  List<Barang> _barangTampil = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _barangTampil = _semuaBarang;
  }

  //fungsi buat search
  void _cariBarang(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        _barangTampil = _semuaBarang;
      } else {
        _barangTampil = _semuaBarang
            .where(
              (barang) =>
                  barang.nama.toLowerCase().contains(keyword.toLowerCase()) ||
                  barang.kategori.toLowerCase().contains(keyword.toLowerCase()),
            )
            .toList();
      }
    });
  }

  Color _warnaStok(int stok) {
    if (stok == 0) return Colors.red;
    if (stok < 5) return Colors.deepOrange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Barang'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          //bagian search
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _cariBarang,
              decoration: InputDecoration(
                hintText: 'Cari nama atau kategori barang',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          //list barang
          Expanded(
            child: _barangTampil.isEmpty
                ? const Center(child: Text('Barang tidak ditemukan'))
                : ListView.builder(
                    itemCount: _barangTampil.length,
                    itemBuilder: (context, index) {
                      final barang = _barangTampil[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            child: const Icon(
                              Icons.inventory,
                              color: Colors.blue,
                            ),
                          ),
                          title: Text(
                            barang.nama,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          //subtitle: kategori & harga satuan
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(barang.kategori),
                              const SizedBox(height: 4),
                              Text(
                                'Harga: Rp ${barang.hargaSatuan.toStringAsFixed(0)} / unit',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          //trailing: stok & total harga
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Stok: ${barang.stok}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _warnaStok(barang.stok),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Total: Rp ${barang.totalHarga.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Kurangi Stok: ${barang.nama}'),
                                  content: const Text(
                                    'Yakin ingin mengurangi stok sebanyak 1?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('BATAL'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (barang.stok > 0) {
                                          setState(() {
                                            final indexAsli = _semuaBarang
                                                .indexOf(barang);
                                            _semuaBarang[indexAsli] = Barang(
                                              id: barang.id,
                                              nama: barang.nama,
                                              kategori: barang.kategori,
                                              stok: barang.stok - 1,
                                              hargaSatuan: barang.hargaSatuan,
                                            );
                                            _cariBarang(_searchController.text);
                                          });
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Stok berhasil dikurangi 1',
                                                  ),
                                                ),
                                              );
                                        } else {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Stok sudah habis'),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Kurangi'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          //tekan lama untk edit dan hapus
                          onLongPress: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        title: const Text('Edit Barang'),
                                        onTap: () async {
                                          Navigator.pop(context);

                                          //pindah ke halaman edit
                                          final barangEdit =
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditBarangScreen(
                                                        barang: barang,
                                                      ),
                                                ),
                                              );

                                          //kalau ada data edit yang dikirim balik
                                          if (barangEdit != null) {
                                            setState(() {
                                              final indexAsli = _semuaBarang
                                                  .indexOf(barang);
                                              _semuaBarang[indexAsli] =
                                                  barangEdit;
                                              _cariBarang(
                                                _searchController.text,
                                              );
                                            });
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Barang berhasil di edit',
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        title: const Text('Hapus Barang'),
                                        onTap: () async {
                                          Navigator.pop(context);

                                          //konfirmasi hapus
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  'Hapus Barang?',
                                                ),
                                                content: Text(
                                                  'Yakin ingin menghapus ${barang.nama}?',
                                                ),

                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text('BATAL'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        _semuaBarang.remove(
                                                          barang,
                                                        );
                                                        _cariBarang(
                                                          _searchController
                                                              .text,
                                                        );
                                                      });
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            'Barang berhasil dihapus',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                    child: const Text(
                                                      'HAPUS',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      //tombol tambah barang
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //panggil halaman TambahBarangScreen
          final barangBaru = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahBarangScreen()),
          );

          //kalau ada data yang dikirim balik (barangBaru gak null)
          if (barangBaru != null) {
            setState(() {
              _semuaBarang.add(barangBaru);
              _barangTampil = _semuaBarang; //update list yang tampil
            });

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Barang berhasil ditambahkan!')),
              );
            }
          }
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
