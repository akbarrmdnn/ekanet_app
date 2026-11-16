import 'package:flutter/material.dart';
import '../models/pengajuan.dart';

class PengajuanScreen extends StatefulWidget{
  const PengajuanScreen({super.key});

  @override
  State<PengajuanScreen> createState() => _PengajuanScreenState();
}

class _PengajuanScreenState extends State<PengajuanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaPengajuController = TextEditingController(); 
  final _namaBarangController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _keteranganController = TextEditingController();

  void _kirimPengajuan(){
    if (_formKey.currentState!.validate()) {
      final pengajuanBaru = Pengajuan( 
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        namaPengaju: _namaPengajuController.text,
        namaBarang: _namaBarangController.text,
        jumlah: int.parse(_jumlahController.text),
        keterangan: _keteranganController.text,
      );

      //kirim balik ke halaman sebelumnya
      Navigator.pop(context, pengajuanBaru);
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Untuk Pengajuan Barang'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Silakan isi form di bawah ini untuk mengajukan pembelian/pengadaan barang baru ke pihak gudang.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              //input nama pengaju
              TextFormField(
                controller: _namaPengajuController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pengaju',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory),
                ),
                validator: (value){
                 if (value == null || value.isEmpty){
                  return 'Nama pengaju wajib di isi';        
                }
                return null;
               },
              ),
              const SizedBox(height: 16),

              //input nama barang
              TextFormField(
                controller: _namaBarangController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang yang Diajukan',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory), 
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return 'Nama barang tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //input jumlah
              TextFormField(
                controller: _jumlahController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Jumlah yang Diajukan',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'Jumlah tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),


              //input keterangan
              TextFormField(
                controller: _keteranganController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Alasan/Keterangan',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'Keterangan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              //tombol kirim
              ElevatedButton(
                onPressed: _kirimPengajuan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'KIRIM PENGAJUAN',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}