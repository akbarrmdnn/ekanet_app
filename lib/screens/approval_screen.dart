import 'package:flutter/material.dart';
import '../models/pengajuan.dart';

class ApprovalScreen extends StatefulWidget {
  final List<Pengajuan> daftarPengajuan;

  const ApprovalScreen({super.key, required this.daftarPengajuan});

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persetujuan Gudang'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: widget.daftarPengajuan.isEmpty
          ? const Center(child: Text('Belum ada pengajuan baru'))
          : ListView.builder(
              itemCount: widget.daftarPengajuan.length,
              itemBuilder: (context, index) {
                final pengajuan = widget.daftarPengajuan[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pengaju: ${pengajuan.namaPengaju}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ), 
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pengajuan.namaBarang,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            //warna status
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: pengajuan.status == 'PENDING'
                                    ? Colors.orange
                                    : (pengajuan.status == 'DISETUJUI'
                                        ? Colors.green
                                        : Colors.red),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                pengajuan.status,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Jumlah: ${pengajuan.jumlah} unit'),
                        Text('Alasan: ${pengajuan.keterangan}'),
                        const SizedBox(height: 12),

                        //tombol aksi kalau masih pending
                        if (pengajuan.status == 'PENDING')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    pengajuan.status = 'DITOLAK';
                                  });
                                },
                                child: const Text('DITOLAK',
                                    style: TextStyle(color: Colors.red)),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    pengajuan.status = 'DISETUJUI';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                child: const Text('SETUJUI',
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ), 
                      ],
                    ),
                  ),
                ); 
              },
            ),
    );
  }
}