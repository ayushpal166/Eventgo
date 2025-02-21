import 'dart:convert';

import 'package:eventgo/services/database.dart';
import 'package:eventgo/services/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  String image, name, location, date, detail, price;
  DetailPage({
    required this.image,
    required this.name,
    required this.location,
    required this.date,
    required this.detail,
    required this.price,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic>? paymentIntent;
  int ticket = 1;
  int total = 0;
  String? name, image, id;

  @override
  void initState() {
    total = int.parse(widget.price);
    ontheload();
    super.initState();
  }

  Future<void> ontheload() async {
    name = await SharedpreferenceHelper().getUserName();
    image = await SharedpreferenceHelper().getUserImage();
    id = await SharedpreferenceHelper().getUserId();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    "images/coldplay.png",
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            margin:
                                const EdgeInsets.only(top: 42.0, left: 20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16.0),
                          width: MediaQuery.of(context).size.width,
                          decoration:
                              const BoxDecoration(color: Colors.black12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    widget.date,
                                    style: TextStyle(
                                      color: Color.fromARGB(211, 255, 255, 255),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    widget.location,
                                    style: TextStyle(
                                      color: Color.fromARGB(211, 255, 255, 255),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "About Concert",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  widget.detail,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 30),
                child: Row(
                  children: [
                    const Text(
                      "Number of Tickets",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 50.0,
                    ),
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54, width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (ticket < 9) {
                                total += int.parse(widget.price);
                                ticket += 1;
                                setState(() {});
                              }
                            },
                            child: Text(
                              "+",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                          Text(
                            ticket.toString(),
                            style: TextStyle(
                                color: Color(0xff6351ec),
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (ticket > 1) {
                                total -= int.parse(widget.price);
                                ticket -= 1;
                                setState(() {});
                              }
                            },
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Row(
                  children: [
                    Text(
                      "Amount : \$" + total.toString(),
                      style: TextStyle(
                          color: Color(0xff6351ec),
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        makePayment(total.toString());
                      },
                      child: Container(
                        height: 45,
                        width: 180,
                        decoration: BoxDecoration(
                            color: const Color(0xff6351ec),
                            borderRadius: BorderRadius.circular(24.0)),
                        child: const Center(
                          child: Text(
                            "Book Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight
                                  .bold, // Fixed incorrect FontWeight usage
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      var paymentIntent = await createPaymentIntent(amount, 'USD');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Eventgo',
        ),
      );

      await displayPaymentSheet(amount);
    } catch (e, s) {
      debugPrint('Exception: $e $s');
    }
  }

  Future<void> displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      Map<String, dynamic> bookingDetail = {
        "Number": "ticket.toString()",
        "Total": "total.toString()",
        "Event": "widget.name",
        "Location": "widget.location",
        "Date": "widget.date",
        "Name": name,
        "Image": image,
        "EventImage": widget.image
      };
      await DatabaseMethods()
          .addUserBooking(bookingDetail, id!)
          .then((value) async {
        await DatabaseMethods().addAdminTickets(bookingDetail);
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 10),
                  const Text("Payment Successful"),
                ],
              ),
            ],
          ),
        ),
      );
    } on StripeException catch (e) {
      debugPrint("Payment Error: $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text("Payment Cancelled"),
        ),
      );
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types': ['card'], // Fixed syntax
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'sk_test_51QseldCEU5CqUOlbMnq12DXwS4CqSianQHwGEyyaHKbpogawvsLB9rvX4N8pfgiPn3kQV6e0IxdPFnNBQe9Ktwb2004USXnZIN', // Replace with your actual Stripe Secret Key
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (err) {
      debugPrint('Error charging user: ${err.toString()}');
      return {};
    }
  }

  String calculateAmount(String amount) {
    final int calculatedAmount = int.parse(amount) * 100;
    return calculatedAmount.toString();
  }
}
