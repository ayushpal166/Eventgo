// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventgo/pages/categories_event.dart';
import 'package:eventgo/pages/detail_page.dart';
import 'package:eventgo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream? eventStream;

  ontheload() async {
    eventStream = await DatabaseMethods().getallEvents();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allEvents() {
    return StreamBuilder(
        stream: eventStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    String inputDate = ds["Date"];
                    DateTime parsedDate = DateTime.parse(inputDate);
                    String formattedDate =
                        DateFormat('MMM dd').format(parsedDate);

                    DateTime currentDate = DateTime.now();
                    bool hasPassed = currentDate.isAfter(parsedDate);

                    return hasPassed
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          date: ds["Date"],
                                          name: ds["Name"],
                                          detail: ds["Detail"],
                                          image: ds["Image"],
                                          location: ds["Location"],
                                          price: ds["Price"])));
                            },
                            child: Column(children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: 20.0,
                                ),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        "images/coldplay.png",
                                        height: 200.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10.0, top: 10.0),
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text(
                                        formattedDate,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ds["Name"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 22.0),
                                    child: Text(
                                      "\$" + ds["Price"],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xff6351ec),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(children: [
                                Icon(Icons.location_on),
                                Text(
                                  ds["Location"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ])
                            ]),
                          );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50.0, left: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: const [
            Color(0xffe3e6ff),
            Color(0xfff1f3ff),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.location_on_outlined),
                  Text(
                    "Ahmedabad, India",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Hello, Chrish",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                "There are 20 events\naround your location.",
                style: TextStyle(
                    color: Color(0xff6351ec),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(right: 20.0),
                padding: EdgeInsets.only(left: 15.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search_outlined),
                      border: InputBorder.none,
                      hintText: "search a event"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoriesEvent(eventcategory: "Music"),
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            width: 130,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/musical.png",
                                  height: 30.0,
                                  width: 30,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "Music",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoriesEvent(eventcategory: "Clothing"),
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            width: 130,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/tshirt.png",
                                  height: 30.0,
                                  width: 30,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "Clothing",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoriesEvent(eventcategory: "Festival"),
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            width: 130,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/confetti.png",
                                  height: 30.0,
                                  width: 30,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "Festival",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoriesEvent(eventcategory: "Food"),
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 20.0),
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            width: 130,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/dish.png",
                                  height: 30.0,
                                  width: 30,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "Food",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Upcoming Events",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Text(
                      "See all",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              allEvents(),
            ],
          ),
        ),
      ),
    );
  }
}
