import 'package:flutter/material.dart';
import 'package:user_auth_crudd10/pages/home_page.dart';
import 'package:user_auth_crudd10/pages/others/answer_page.dart';
import 'package:user_auth_crudd10/pages/others/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color _iconColor(int index) {
    return _selectedIndex == index
        ? Theme.of(context).colorScheme.secondary
        : Colors.grey;
  }

  List<Widget> _pages = [
    HomePage(),
    AnswerPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: BottomNavigationBar(
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.grey[500],
          // backgroundColor: Colors.transparent,
          currentIndex: _selectedIndex,
          onTap: _changeIndex,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/ic_home.png",
                color: _iconColor(0),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/ic_ans.png",
                color: _iconColor(1),
                scale: 25,
              ),
              label: "Answers",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/ic_p.png",
                color: _iconColor(2),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
