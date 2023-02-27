import 'package:kai_mobile/screens/home_screen.dart';
import 'package:kai_mobile/screens/search_screen.dart';
import 'package:kai_mobile/screens/ticket_screen.dart';
import 'package:kai_mobile/screens/profile_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:kai_mobile/utils/app_styles.dart';

class BottomBar extends StatefulWidget {
  int selectedIndex = 0;
  BottomBar(@required this.selectedIndex);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    // const SearchScreen(),
    const TicketScreen(),
    const ProfileScreen(),
  ];
  // fun to change index
  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions[widget.selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: widget.selectedIndex,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color.fromARGB(255, 16, 194, 197),
        unselectedItemColor: const Color(0xFF546480),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
              label: "Home"),
          // BottomNavigationBarItem(
          //     icon: Icon(FluentSystemIcons.ic_fluent_search_regular),
          //     activeIcon: Icon(FluentSystemIcons.ic_fluent_search_filled),
          //     label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_ticket_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_ticket_filled),
              label: "Tickets"),
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
              label: "Profile"),
        ],
      ),
    );
  }
}
