import 'package:flutter/material.dart';
import '../models/barang.dart';

class BarangListScreen extends StatefulWidget{
  const BarangListScreen({super.key});

  @override
  State<BarangListScreen> createState() => _BarangListScreenState();
}

class _BarangListScreenState extends State <BarangListScreen>{
  //data dummy sementara
  final List <Barang> _semuaBarang = [
    Barang(id: '1', nama: 'Router Mikrotik RB750', kategori: 'Jaringan', stok: 15, harga: 850000),
    Barang(id: '2', nama: 'Kabel Fiber Optic 1 Roll', kategori: 'Kabel', stok: 3, harga: 2500000),
    Barang(id: '3', nama: 'ONT / Modem Huawei', kategori: 'Perangkat Klien', stok: 45, harga: 350000),
    Barang(id: '4', nama: 'Splicer Fiber Optic', kategori: 'Alat Kerja', stok: 2, harga: 15000000),
    Barang(id: '5', nama: 'Konektor SC/UPC (100 pcs)', kategori: 'Aksesoris', stok: 0, harga: 150000),
    Barang(id: '6', nama: 'Access Point TP-Link', kategori: 'Jaringan', stok: 8, harga: 450000),
    Barang(id: '7', nama: 'Tangga Lipat Fiber', kategori: 'Alat Kerja', stok: 4, harga: 1200000),
    Barang(id: '8', nama: 'Kabel LAN Cat6 (1 Roll)', kategori: 'Kabel', stok: 10, harga: 1800000),
  ];

  List <Barang>_barangTampil = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _barangTampil = _semuaBarang;
  }
    
  //fungsi buat search
  void _cariBarang(String keyword){
     setState(() {
       if (keyword.isEmpty){
        _barangTampil = _semuaBarang;
       } else{
        _barangTampil = _semuaBarang
           .where((barang) => 
             barang.nama.toLowerCase().contains(keyword.toLowerCase()) ||
             barang.kategori.toLowerCase().contains(keyword.toLowerCase())).toList();          
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
                  borderRadius: BorderRadius.circular(10)
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
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(Icons.inventory, color: Colors.blue),
                  ),
                  title: Text(
                    barang.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                  subtitle: Text(
                   '${barang.kategori} • Rp ${barang.harga.toStringAsFixed(0)}',
                  ),
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
                      if (barang.stok==0)
                      const Text(
                        'Habis',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )
                    ],
                  ),
                  onTap: (){

                  },
                ),
              );
             },
          ),
         )
        ],
      ),
      //button tambah barang
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         //nanti di redirect ke form tambah barang
          ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Fitur Tambah Barang belum dibuat')),
         );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}