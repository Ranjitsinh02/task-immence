import 'package:flutter/material.dart';
import 'package:practical_task/ui/profile_screen.dart';

import '../utils/app_color.dart';
import '../utils/app_strings.dart';
import 'UserListScreen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});
  static String id = 'bottomSheet';
  static const List<Widget> _widgetOptions = <Widget>[
    UserListScreen(),
    ProfileScreen(),
  ];

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BottomNavigationBarWidget._widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity_sharp, size: 24,),
                label: AppStrings.users,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,size: 24),
                label: AppStrings.user,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          currentIndex: _selectedIndex,
          unselectedItemColor: AppColor.borderColorTextFormField,
          selectedItemColor: AppColor.darkBlue,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}
