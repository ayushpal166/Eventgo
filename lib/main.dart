import 'package:eventgo/admin/ticket_event.dart';
import 'package:eventgo/admin/upload_event.dart';
import 'package:eventgo/pages/book.dart';
import 'package:eventgo/pages/booking.dart';
import 'package:eventgo/pages/bottomnav.dart';
import 'package:eventgo/pages/categories_event.dart';
import 'package:eventgo/pages/detail_page.dart';
import 'package:eventgo/pages/home.dart';
import 'package:eventgo/pages/signup.dart';
import 'package:eventgo/services/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishedKey;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BottomNav(),
    );
  }
}
