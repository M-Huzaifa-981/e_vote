import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../features/analysis/view/analysis_screen.dart';
import '../features/elections/view/elections_screen.dart';
import '../features/home/view/home_screen.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({Key? key}) : super(key: key);

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  int _index = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    ElectionsScreen(),
    AnalysisScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldGreen,
      body: SafeArea(child: _pages[_index]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -1),
            )
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: AppColors.primaryGreen,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.how_to_vote_outlined),
              label: 'Elections',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              label: 'Stats',
            ),
          ],
        ),
      ),
    );
  }
}