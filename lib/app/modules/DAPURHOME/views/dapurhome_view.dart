import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/dapur1/views/dapur1_view.dart';
import 'package:myapp/app/modules/dapur2/views/dapur2_view.dart';
import 'package:myapp/app/modules/dapur3/views/dapur3_view.dart';
import 'package:myapp/app/modules/dapur4/views/dapur4_view.dart';
import 'package:myapp/app/modules/homeruangtamu/views/homeruangtamu_view.dart';
import 'package:myapp/app/modules/home2/views/home2_view.dart';
import 'package:myapp/app/modules/historypage/views/historypage_view.dart';
import 'package:myapp/app/modules/kamar/views/kamar_view.dart';
import 'package:myapp/app/modules/profilepage/views/profilepage_view.dart';

// Define constants for colors
class AppColors {
  static const Color primary = Color(0xFF562B08); // Brown
  static const Color background = Color(0xFFF5F7F8); // Light gray background
  static const Color cardBg = Color(0xFFFFFFF0); // Ivory
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFFDDDDDD);
  static const Color inactive = Color(0xFFEEEEEE);
}

class InteriorCard {
  final String image;
  final String title;
  final String description;
  final Widget destination;

  InteriorCard({
    required this.image,
    required this.title,
    required this.description,
    required this.destination,
  });
}

class dapurhomeView extends StatefulWidget {
  @override
  _DAPURViewState createState() => _DAPURViewState();
}

class _DAPURViewState extends State<dapurhomeView> {
  int _selectedIndex = 0;
  int _selectedTabIndex = 1;

  final List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  final List<InteriorCard> interiorCards = [
    InteriorCard(
      image: 'assets/dapur1.jpg',
      title: 'BELGIA',
      description: 'Dapur Bergaya Casual',
      destination: dapur1View(),
    ),
    InteriorCard(
      image: 'assets/dapur2.jpg',
      title: 'ITALY',
      description: 'Dapur Bergaya Modern',
      destination: Dapur2View(),
    ),
    InteriorCard(
      image: 'assets/dapur3.jpg',
      title: 'AMERIKA',
      description: 'Dapur dengan Nuansa Klasik',
      destination: Dapur3View(),
    ),
    InteriorCard(
      image: 'assets/dapur4.jpg',
      title: 'EUROPA',
      description: 'Dapur Bergaya Kompterur',
      destination: dapur4View(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Interior & Construction',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              'assets/LOGO_YUMANSA.png',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTabButton('Kamar', _selectedTabIndex == 0, () {
                    setState(() => _selectedTabIndex = 0);
                    Get.to(() => KamarView());
                  }),
                  buildTabButton('Dapur', _selectedTabIndex == 1, () {
                    setState(() => _selectedTabIndex = 1);
                  }),
                  buildTabButton('Ruang Tamu', _selectedTabIndex == 2, () {
                    setState(() => _selectedTabIndex = 2);
                    Get.to(() => HomeruangtamuView());
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.85,
                ),
                itemCount: interiorCards.length,
                itemBuilder: (context, index) {
                  return buildCardItem(context, interiorCards[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          //borderRadius: const BorderRadius.only(
          //topLeft: Radius.circular(20),
          //topRight: Radius.circular(20),
          // ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: AppColors.textSecondary,
          elevation: 0,
          onTap: (index) {
            setState(() => _selectedIndex = index);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => _pages[index]),
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabButton(String label, bool isSelected, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: isSelected ? AppColors.primary : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildCardItem(BuildContext context, InteriorCard card) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => card.destination),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: Image.asset(
                  card.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    card.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
