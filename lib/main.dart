import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/pages/chat_page.dart';
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/pages/regaster_page.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: 
      {
       'LoginPage' : (context) => LoginPage(),
       'RegesterPage': (context) => RegesterPage(),
       'ChatPage':(context) => ChatPage(),
      },
      initialRoute: 'LoginPage',
    );
  }
}
