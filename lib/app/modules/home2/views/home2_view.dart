import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:myapp/app/modules/DAPURHOME/views/dapurhome_view.dart';
import 'package:myapp/app/modules/historypage/views/historypage_view.dart';
import 'package:myapp/app/modules/homeruangtamu/views/homeruangtamu_view.dart';
import 'package:myapp/app/modules/kamar/views/kamar_view.dart';
import 'package:myapp/app/modules/profilepage/views/profilepage_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of widgets for each tab (Home, History, Profile)
  final List<Widget> _pages = [
    const HomeScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Get.to(() => HistoryPage()); // Navigasi ke HistoryPage dengan GetX
      } else if (index == 2) {
        Get.to(() => ProfilePage()); // Navigasi ke ProfilePage dengan GetX
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_selectedIndex], // Show selected page
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // When a tab is tapped
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                'assets/LOGO_YUMANSA.png',
                height: 40,
              ),
              const SizedBox(width: 8),
              const Text(
                'Interior & Construction',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildCategoryButton('Kamar', () => Get.to(() => KamarView())),
            _buildCategoryButton('Dapur', () => Get.to(() => dapurhomeView())),
            _buildCategoryButton(
                'Ruang Tamu', () => Get.to(() => HomeruangtamuView())),
          ],
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'SELAMAT DATANG DI',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF941B00)),
              ),
              Text(
                'YUMANSA JAYA INTERIOR',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF941B00)),
              ),
              SizedBox(height: 8),
              Text(
                'SILAHKAN PILIH KATEGORI RUANGAN YANG',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                'ANDA INGINKAN',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCategoryButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('History Page'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Page'),
    );
  }
}
