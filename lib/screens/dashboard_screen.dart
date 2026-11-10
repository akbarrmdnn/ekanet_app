import 'package:flutter/material.dart';
import 'barang_list_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Ekanet'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          //tombol Logout
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context); 
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang, Admin!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            //kartu ringkasan
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    'Total Barang',
                    '120',
                    Icons.inventory,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    'Stok Menipis',
                    '5',
                    Icons.warning_amber,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            //menu utama
            const Text(
              'Menu Utama',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            
            //list menu
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.list, color: Colors.blue),
                title: const Text('Daftar Barang'),
                subtitle: const Text('Lihat dan kelola semua barang'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BarangListScreen()),
                  );
                },
              ),
            ),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.add_box, color: Colors.green),
                title: const Text('Tambah Barang Baru'),
                subtitle: const Text('Input barang masuk'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  //arahkan ke form tambah barang
                },
              ),
            ),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.history, color: Colors.purple),
                title: const Text('Riwayat Transaksi'),
                subtitle: const Text('Laporan stok masuk & keluar'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  //arahkan ke halaman riwayat
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //widget bantuan buat bikin kartu ringkasan (biar gak nulis kode panjang 2x)
  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}