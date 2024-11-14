import 'package:flutter/material.dart';

class OrderItem {
  final String nama;
  final double harga;
  final String imageUrl;
  bool isSelected;
  int jumlah;

  OrderItem({
    required this.nama,
    required this.harga,
    required this.imageUrl,
    this.isSelected = false,
    this.jumlah = 1,
  });
}

class OrderPage extends StatefulWidget {
  final List<OrderItem> cartItems;

  const OrderPage({super.key, required this.cartItems});

  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> {
  double discountPercentage = 5.0; // Default 5% diskon

  void _toggleSelection(OrderItem item) {
    setState(() {
      item.isSelected = !item.isSelected;
    });
  }

  void _increaseQuantity(OrderItem item) {
    setState(() {
      item.jumlah++;
    });
  }

  void _decreaseQuantity(OrderItem item) {
    setState(() {
      if (item.jumlah > 1) item.jumlah--;
    });
  }

  double get totalPrice {
    return widget.cartItems.where((item) => item.isSelected).fold(0, (sum, item) => sum + (item.harga * item.jumlah));
  }

  double get totalPriceAfterDiscount {
    // Menghitung harga setelah diskon berdasarkan persentase diskon yang dipilih
    return totalPrice * (1 - discountPercentage / 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Page'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        color: Colors.pink[50],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Keranjang Anda',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Produk yang Anda tambahkan ke keranjang akan muncul di sini.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    OrderItem item = widget.cartItems[index];
                    return ListTile(
                      leading: Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(item.nama),
                      subtitle: Text("Rp ${item.harga} x ${item.jumlah}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => _decreaseQuantity(item),
                          ),
                          Text(item.jumlah.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => _increaseQuantity(item),
                          ),
                          Checkbox(
                            value: item.isSelected,
                            onChanged: (bool? value) {
                              _toggleSelection(item);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Total Harga: Rp ${totalPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Diskon: ${discountPercentage.toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              // Dropdown untuk memilih persentase diskon
              DropdownButton<double>(
                value: discountPercentage,
                onChanged: (double? newValue) {
                  setState(() {
                    discountPercentage = newValue!;
                  });
                },
                items: [5.0, 10.0, 15.0, 20.0].map<DropdownMenuItem<double>>((double value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text('$value%'),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Text(
                'Harga Setelah Diskon: Rp ${totalPriceAfterDiscount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  List<OrderItem> selectedItems = widget.cartItems.where((item) => item.isSelected).toList();

                  if (selectedItems.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pilih produk yang ingin dipesan')),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransaksiPage(
                          items: selectedItems,
                          totalPriceAfterDiscount: totalPriceAfterDiscount,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  'Lanjut ke Transaksi',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransaksiPage extends StatefulWidget {
  final List<OrderItem> items;
  final double totalPriceAfterDiscount;

  const TransaksiPage({super.key, required this.items, required this.totalPriceAfterDiscount});

  @override
  TransaksiPageState createState() => TransaksiPageState();
}

class TransaksiPageState extends State<TransaksiPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  String selectedPaymentMethod = 'Transfer Bank';

  final List<String> paymentMethods = [
    'Transfer Bank',
    'Kartu Kredit',
    'Dompet Digital',
    'Cash on Delivery',
  ];

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  double get totalPrice {
    return widget.items.fold(0, (sum, item) => sum + (item.harga * item.jumlah));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.pink[50],
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Detail Transaksi',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text('Nama:'),
              TextField(controller: nameController),
              const SizedBox(height: 10),
              const Text('Nomor Telepon:'),
              TextField(controller: phoneController),
              const SizedBox(height: 10),
              const Text('Alamat:'),
              TextField(controller: addressController),
              const SizedBox(height: 10),
              const Text('Jam Kirim:'),
              InkWell(
                onTap: () => _selectTime(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: selectedTime == null ? 'Pilih Jam' : selectedTime!.format(context),
                  ),
                  child: selectedTime == null
                      ? const Text('Pilih Jam')
                      : Text(selectedTime!.format(context)),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Tanggal Kirim:'),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: selectedDate == null ? 'Pilih Tanggal' : '${selectedDate!.toLocal()}'.split(' ')[0],
                  ),
                  child: selectedDate == null
                      ? const Text('Pilih Tanggal')
                      : Text('${selectedDate!.toLocal()}'.split(' ')[0]),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Metode Pembayaran:'),
              DropdownButton<String>(
                value: selectedPaymentMethod,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPaymentMethod = newValue!;
                  });
                },
                items: paymentMethods.map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                'Total Harga Setelah Diskon: Rp ${widget.totalPriceAfterDiscount.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pesanan Berhasil')),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Konfirmasi Pesanan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}