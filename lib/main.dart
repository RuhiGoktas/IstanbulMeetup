import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth for login
import 'package:url_launcher/url_launcher.dart';  // For opening Google Form URL

// Import screens
import 'screens/homescreen.dart'; // Adjust path if needed
import 'screens/login.dart';      // Adjust path if needed

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized

  // Initialize Firebase
  try {
    print("Initializing Firebase...");
    await Firebase.initializeApp();
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(MyApp());
}

// Main Application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetup Clone',
      theme: ThemeData(
        primarySwatch: Colors.red, // Theme color
      ),
      initialRoute: '/', // Default route
      routes: {
        '/': (context) => FirebaseAuth.instance.currentUser == null
            ? LoginPage() // Redirect to Login if not authenticated
            : HomeScreen(), // Otherwise, go to Home
        '/rsvp': (context) => RSVPPage(),
      },
    );
  }
}

// RSVP Page for handling Google Form link
class RSVPPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Receive the Google Form URL as an argument
    final String googleFormUrl =
        ModalRoute.of(context)!.settings.arguments as String;

    // Function to open URL
    Future<void> _launchURL() async {
      if (await canLaunch(googleFormUrl)) {
        await launch(googleFormUrl);
      } else {
        throw 'Could not launch $googleFormUrl';
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('RSVP')),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchURL, // Launch the Google Form link
          child: Text('Open RSVP Form'),
        ),
      ),
    );
  }
}
