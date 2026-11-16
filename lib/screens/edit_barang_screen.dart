import 'package:flutter/material.dart';

import '../models/barang.dart';

class EditBarangScreen extends StatefulWidget {
  final Barang barang;
  const EditBarangScreen({super.key, required this.barang});

  @override
  State<EditBarangScreen> createState() => _EditBarangScreenState();
}

class _EditBarangScreenState extends State<EditBarangScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _namaController;
  late TextEditingController _kategoriController;
  late TextEditingController _hargaController;
  late TextEditingController _stokController;

  @override
  void initState() {
    super.initState();
    //isi otomatis form barang dengan data barang yang mau di edit
    _namaController = TextEditingController(text: widget.barang.nama);
    _kategoriController = TextEditingController(text: widget.barang.kategori);
    _hargaController = TextEditingController(
      text: widget.barang.hargaSatuan.toStringAsFixed(0),
    );
    _stokController = TextEditingController(
      text: widget.barang.stok.toString(),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _kategoriController.dispose();
    _hargaController.dispose();
    _stokController.dispose();
    super.dispose();
  }

  void _simpanPerubahan() {
    if (_formKey.currentState!.validate()) {
      //bikin object barang baru dengan data yg udh di edit
      final barangEdit = Barang(
        id: widget.barang.id,
        nama: _namaController.text,
        kategori: _kategoriController.text,
        hargaSatuan: double.parse(_hargaController.text),
        stok: int.parse(_stokController.text),
      );

      Navigator.pop(context, barangEdit);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Barang'),
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
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory_2),
                ),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _kategoriController,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hargaController,
                decoration: const InputDecoration(
                  labelText: 'Harga Satuan (Rp)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (value) =>
                    double.tryParse(value ?? '') == null ? 'Harus Angka' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stokController,
                decoration: const InputDecoration(
                  labelText: 'Stok',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (value) =>
                    double.tryParse(value ?? '') == null ? 'Harus Angka' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _simpanPerubahan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'SIMPAN PERUBAHAN',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
