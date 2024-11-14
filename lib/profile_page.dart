import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName = "Nama Pengguna"; // Contoh data nama pengguna
  final String userEmail = "email@domain.com"; // Contoh data email

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.pink, // Ganti warna AppBar menjadi pink
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture and Name
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile.jpeg'), // Ganti dengan gambar yang valid jika diperlukan
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userName, // Ganti dengan nama pengguna dinamis
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userEmail, // Ganti dengan email dinamis
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Menu Options
              const Text(
                'Menu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.account_circle, color: Colors.pink),
                title: const Text('Edit Profil'),
                onTap: () {
                  // Navigasi ke halaman edit profil (jika ada)
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.pink),
                title: const Text('Pengaturan'),
                onTap: () {
                  // Navigasi ke halaman pengaturan (jika ada)
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications, color: Colors.pink),
                title: const Text('Notifikasi'),
                onTap: () {
                  // Navigasi ke halaman notifikasi
                },
              ),
              ListTile(
                leading: const Icon(Icons.live_help, color: Colors.pink),
                title: const Text('Pusat Bantuan'),
                onTap: () {
                  // Navigasi ke halaman pusat bantuan
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Keluar'),
                onTap: () {
                  // Fungsi log out
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}