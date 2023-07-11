import 'package:flutter/material.dart';
import 'package:testproject/ui/HistoryPage/history_page.dart';
import 'package:testproject/ui/MyPetsScreen/my_pets_screen.dart';

import '../core/constants/color_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int index = 0;
  List<Widget> screens = [
    const MyPetsScreen(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value){
          setState(() {
            index = value;
          });
        },
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.pets_rounded), label: "My Pets"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
      ],
      ),
    );
  }
}
