import 'package:flutter/material.dart';
import 'order.dart'; // Pastikan mengimpor file OrderItem

class BerandaPage extends StatefulWidget {
  final Function(OrderItem) onAddToCart; // Callback untuk menambahkan produk ke keranjang

  const BerandaPage({super.key, required this.onAddToCart});

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  String selectedCategory = 'Semua'; // Variabel untuk kategori yang dipilih

  // Daftar produk
  final List<Map<String, dynamic>> products = [
    {'name': 'Celana Highwaist Pant Wanita Rosepeach', 'category': 'Pakaian', 'price': 250000, 'image': 'assets/Celana1.jpg'},
    {'name': 'Celana Highwaist Pant Wanita BW', 'category': 'Pakaian', 'price': 275000, 'image': 'assets/Celana2.jpg'},
    {'name': 'Celana Highwaist Pant Wanita Latte', 'category': 'Pakaian', 'price': 300000, 'image': 'assets/Celana3.jpg'},
    {'name': 'Dres Set Korean', 'category': 'Pakaian', 'price': 220000, 'image': 'assets/Dres1.jpg'},
    {'name': 'Dres Korean White', 'category': 'Pakaian', 'price': 320000, 'image': 'assets/Dres2.jpg'},
    {'name': 'Dres Korean Lucu', 'category': 'Pakaian', 'price': 280000, 'image': 'assets/Dres3.jpg'},
    {'name': 'Cushion Skintific Biru', 'category': 'Kecantikan', 'price': 150000, 'image': 'assets/Cushion Skintific Biru.jpg'},
    {'name': 'Lipmate Maybelline', 'category': 'Kecantikan', 'price': 130000, 'image': 'assets/Lipmate Maybelline.jpg'},
    {'name': 'Lipmate Implora', 'category': 'Kecantikan', 'price': 100000, 'image': 'assets/lip implora.jpg'},
    {'name': 'Skincare Innisfree', 'category': 'Kecantikan', 'price': 190000, 'image': 'assets/skincare innisfree.jpg'},
    {'name': 'Skincare Skintific', 'category': 'Kecantikan', 'price': 180000, 'image': 'assets/skincare skintific.jpg'},
    {'name': 'Skincare Centela', 'category': 'Kecantikan', 'price': 160000, 'image': 'assets/skincare centela.jpg'},
    {'name': 'Lipmate Wardah', 'category': 'Kecantikan', 'price': 120000, 'image': 'assets/lipmate wardah.jpg'},
    {'name': 'Raket Tenis', 'category': 'Olahraga', 'price': 450000, 'image': 'assets/raket.jpg'},
    {'name': 'Bola Basket', 'category': 'Olahraga', 'price': 250000, 'image': 'assets/bola basket.jpg'},
    {'name': 'Skipping Rope', 'category': 'Olahraga', 'price': 100000, 'image': 'assets/skipping.jpg'},
    {'name': 'Laptop Lenovo', 'category': 'Elektronik', 'price': 7000000, 'image': 'assets/laptop lenovo.jpg'},
    {'name': 'Laptop IP', 'category': 'Elektronik', 'price': 10000000, 'image': 'assets/laptop ip.jpg'},
    {'name': 'Laptop Asus', 'category': 'Elektronik', 'price': 8500000, 'image': 'assets/laptop asus.jpg'},
  ];

  // Fungsi untuk memfilter produk berdasarkan kategori yang dipilih
  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == 'Semua') {
      return products;
    }
    return products.where((product) => product['category'] == selectedCategory).toList();
  }

  // Fungsi untuk mengubah kategori yang dipilih
  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image
          Container(
            margin: const EdgeInsets.all(10),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage('assets/Kategori.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Kategori Grid
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Kategori',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GridView.builder(
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              final List<String> categoryNames = [
                'Semua', 'Pakaian', 'Elektronik', 'Kecantikan', 'Olahraga', 'Rumah Tangga', 'Buku', 'Mainan', 'Makanan',
              ];
              final List<IconData> categoryIcons = [
                Icons.category, Icons.checkroom, Icons.devices, Icons.brush, Icons.sports_soccer,
                Icons.kitchen, Icons.book, Icons.toys, Icons.fastfood,
              ];

              return GestureDetector(
                onTap: () => selectCategory(categoryNames[index]),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        categoryIcons[index],
                        color: Colors.pink,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      categoryNames[index],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          ),

          // Produk Populer berdasarkan kategori
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Produk Populer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GridView.builder(
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),

                              Image.asset(
                                product['image'],
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                product['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Rp${product['price']}',
                                style: const TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton.icon(
                                onPressed: () {
                                  final item = OrderItem(
                                    nama: product['name'],
                                    harga: product['price'].toDouble(),
                                    imageUrl: product['image'],
                                    isSelected: false,
                                    jumlah: 1,
                                  );

                                  widget.onAddToCart(item);

                                  Navigator.pop(context);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product['name']} telah ditambahkan ke keranjang'),
                                      duration: const Duration(seconds: 2),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.shopping_cart),
                                label: const Text('Tambah ke Keranjang'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.asset(
                          product['image'],
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          product['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Rp${product['price']}',
                          style: const TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
