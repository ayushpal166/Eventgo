import 'package:eventgo/services/auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Image.asset("images/onboarding.png"),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Unlock the Future of",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Event Booking App",
              style: TextStyle(
                  color: Color(0xff6351ec),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              "Discover, book and experience unforgettable moments effortlessly",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black38,
                fontSize: 21.0,
              ),
            ),
            const SizedBox(
              height: 55.0,
            ),
            GestureDetector(
              onTap: () {
                AuthMethods().signInWithGoogle(context);
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.only(left: 35.0, right: 35.0),
                decoration: BoxDecoration(
                    color: const Color(0xff6351ec),
                    borderRadius: BorderRadius.circular(40.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/google.png",
                      height: 25,
                      width: 25,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    const Text(
                      "Sign in with Google",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
