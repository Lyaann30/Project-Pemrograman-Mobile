import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/DAPURHOME/views/dapurhome_view.dart';
import 'package:myapp/app/modules/homeruangtamu/views/homeruangtamu_view.dart';
import 'package:myapp/app/modules/kamaramerika1/views/kamaramerika1_view.dart';
import 'package:myapp/app/modules/kamareropa1/views/kamareropa1_view.dart';
import 'package:myapp/app/modules/kamarjapan1/views/kamarjapan1_view.dart';
import 'package:myapp/app/modules/kamarspanyol1/views/kamarspanyol1_view.dart';
import 'package:myapp/app/modules/home2/views/home2_view.dart';
import 'package:myapp/app/modules/historypage/views/historypage_view.dart';
import 'package:myapp/app/modules/profilepage/views/profilepage_view.dart';

// Define constants for colors
class AppColors {
  static const Color primary = Color(0xFF562B08); // Brown
  static const Color background = Color(0xFFF5F7F8); // Light gray
  static const Color cardBg = Color(0xFFFFFFF0); // Ivory
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.grey;
}

class KamarView extends StatefulWidget {
  @override
  _KamarViewState createState() => _KamarViewState();
}

class _KamarViewState extends State<KamarView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
    ProfilePage(),
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
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              'assets/LOGO_YUMANSA.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTabButton('Kamar', _selectedIndex == 0, () {
                  setState(() => _selectedIndex = 0);
                }),
                buildTabButton('Dapur', _selectedIndex == 1, () {
                  Get.to(() => dapurhomeView());
                }),
                buildTabButton('Ruang Tamu', _selectedIndex == 2, () {
                  Get.to(() => HomeruangtamuView());
                }),
              ],
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
                itemCount: 4,
                itemBuilder: (context, index) {
                  return buildCardItem(context, index);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: AppColors.primary,
        selectedItemColor: Colors.white,
        unselectedItemColor: AppColors.textSecondary,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
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
            label: 'Histori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
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
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget buildCardItem(BuildContext context, int index) {
    List<Widget> kamarPages = [
      Kamarspanyol1View(),
      Kamaramerika1View(),
      Kamareropa1View(),
      Kamarjapan1View(),
    ];

    List<String> imageAssets = [
      'assets/kamar1.jpg',
      'assets/kamar2.jpg',
      'assets/kamar3.jpg',
      'assets/kamar4.jpg',
    ];

    List<String> titles = [
      'Spanyol',
      'Amerika Klasik',
      'Eropa',
      'Japan',
    ];

    List<String> descriptions = [
      'Fasilitas penuh gaya, cocok untuk ruang tidur modern.',
      'Hangat, berdekor klasik, perabot kayu, detail elegan, nyaman.',
      'Mewah, klasik, ornamen indah, warna netral, pencahayaan lembut.',
      'Minimalis, tatami, pintu geser, kayu alami, atmosfer tenang.',
    ];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => kamarPages[index]),
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
                  imageAssets[index],
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
                    titles[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    descriptions[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
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
