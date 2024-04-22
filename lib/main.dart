import 'package:contactsbook/controllers/auth_services.dart';
import 'package:contactsbook/controllers/notification.dart';
import 'package:contactsbook/views/contact/add_contact_page.dart';
import 'package:contactsbook/views/home.dart';
import 'package:contactsbook/views/login_page.dart';
import 'package:contactsbook/views/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationHelper.init();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCB_A8VlzHeWzIu6ggHbM04rAW-hGW6EyI",
          // authDomain: "contactsbook-ee7fd.firebaseapp.com",
          projectId: "contactsbook-ee7fd",
          // storageBucket: "contactsbook-ee7fd.appspot.com",
          messagingSenderId: "574706375236",
          appId: "1:574706375236:web:f8f9280cd6b5318c883a11",
          // measurementId: "G-H87N10ZKXE"
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.soraTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade800),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => CheckUser(),
        "/home": (context) => Homepage(),
        "/signup": (context) => SignUpPage(),
        "/login": (context) => LoginPage(),
        "/add": (context) => AddContact()
      },
    );
  }
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    AuthService().isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset("images/contact.jpg"),
            SizedBox(height: 10,),
            Text("ContactBook"),
          ],
        ),
      ),
    );
  }
}