import 'package:firebase_auth_flow/views/notes_page.dart';
import 'package:firebase_auth_flow/views/profile_page.dart';
import 'package:firebase_auth_flow/views/about-page.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    NotesPage(),
    ProfilePage(),
    AboutPage(),
  ];
  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[200],
      currentIndex: selectedIndex,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Notlar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_rounded),
          label: 'Hakkında',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
    );
  }
}
