import 'package:contactsbook/views/contact/history_call.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controllers/auth_services.dart';
import 'appointment/appointment.dart';
import 'contact/contact.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  final tabs = [
    Contact(),
    HistoryCall(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        maxRadius: 32,
                        child: Text(FirebaseAuth.instance.currentUser!.email
                            .toString()[0]
                            .toUpperCase()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(FirebaseAuth.instance.currentUser!.email.toString())
                    ],
                  )),
              ListTile(
                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => Appointment())),
                leading: Icon(Icons.book_rounded),
                title: Text("List Appointment"),
              ),
              ListTile(
                onTap: () {
                  AuthService().logout();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Logged Out")));
                  Navigator.pushReplacementNamed(context, "/login");
                },
                leading: Icon(Icons.logout_outlined),
                title: Text("Logout"),
              )
            ],
          )),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // selectedFontSize: 0.0,
        // unselectedFontSize: 0.0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_page_sharp),
              label: "contact"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "history"
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
