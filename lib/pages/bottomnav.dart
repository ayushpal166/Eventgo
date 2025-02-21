import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventgo/pages/booking.dart';
import 'package:eventgo/pages/home.dart';
import 'package:eventgo/pages/profile.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;
  late Home home;
  late Booking booking;
  late Profile profile;
  int currentTabIndex = 0;

  @override
  void initState() {
    home = const Home();
    booking = const Booking();
    profile = const Profile();
    pages = [home, booking, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 60.0,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: const Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: const [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 30.0,
            ),
            Icon(
              Icons.book,
              color: Colors.white,
              size: 30.0,
            ),
            Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 30.0,
            )
          ]),
      body: pages[currentTabIndex],
    );
  }
}
