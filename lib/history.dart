import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> _orderHistory = [];

  @override
  void initState() {
    super.initState();
    _loadOrderHistory();
  }

  // Fungsi untuk memuat riwayat pesanan dari SharedPreferences
  Future<void> _loadOrderHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedOrders = prefs.getStringList('order_history');
    
    if (savedOrders != null) {
      setState(() {
        _orderHistory = savedOrders;
      });
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: _orderHistory.isEmpty
          ? const Center(
              child: Text('Belum ada pesanan'),
            )
          : ListView.builder(
              itemCount: _orderHistory.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(_orderHistory[index]),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // Tindakan saat item riwayat dipilih (opsional)
                    },
                  ),
                );
              },
            ),
    );
  }
}
