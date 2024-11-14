import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'beranda.dart';
import 'order.dart'; // Import halaman order

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<OrderItem> cartItems = []; // Menyimpan item yang ada di keranjang

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _addToCart(OrderItem item) {
    setState(() {
      cartItems.add(item); // Menambahkan produk ke keranjang
    });
  }

  @override
  Widget build(BuildContext context) {
    // Menyesuaikan ukuran font berdasarkan lebar layar perangkat
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSizeAppBar = screenWidth > 400 ? 20 : 16; // Ukuran font responsif untuk AppBar
    double fontSizeNavLabel = screenWidth > 400 ? 12 : 10; // Ukuran font label bottom navigation

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aplikasi Sisam',
          style: TextStyle(fontSize: fontSizeAppBar), // Menyesuaikan ukuran font AppBar
        ),
        backgroundColor: Colors.pink,
        elevation: 0, // Mengurangi bayangan di bawah AppBar
        toolbarHeight: 60, // Menyesuaikan tinggi AppBar agar lebih kompak di layar kecil
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Pass the callback function to BerandaPage
          BerandaPage(onAddToCart: _addToCart), // Mengirim fungsi _addToCart ke BerandaPage
          OrderPage(cartItems: cartItems), // Menampilkan halaman order dengan item di keranjang
          const ProfilePage(), // Profil Page
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',  // Menambahkan tab History
          ),
        ],
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: fontSizeNavLabel), // Menyesuaikan ukuran font label
        unselectedLabelStyle: TextStyle(fontSize: fontSizeNavLabel), // Menyesuaikan ukuran font label
        iconSize: 24, // Menyesuaikan ukuran icon
      ),
    );
  }
}
