import 'package:flutter/material.dart';

import 'MyAppointments.dart';
import 'Screen/LoginScreen.dart';
import 'Screen/Myprofile.dart';
import 'Screen/RegisterScreen.dart';
import 'Screen/Verify_otp.dart';
import 'SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    initialRoute: 'splash',
    routes: {
      // 'new' : (context) => New(),
      'splash': (context) => splashScreen(),
       'login' : (context) => Login(),
       'register' : (context) => Register(),
       // 'myAppointments' : (context) => MyAppointments(),
       'verify' : (context) => Verify(),
      // 'terms' : (context) => Terms(),
      // 'faq' : (context) => FaqScreen(),
       'myprofile' : (context) => MyProfile(),
      // 'support' : (context) => Support(),
      // 'appointmentDetails' : (context) => AppointmentDetails(),
    }
    );
  }
}


