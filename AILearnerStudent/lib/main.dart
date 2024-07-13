import 'package:ailearner/services/AuthGate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "--your-api-key--",
          appId: "--your-app-ID--",
          messagingSenderId: "--your-messagingSenderId--",
          projectId: "--your-project-id--",),
    );
  }

  await Firebase.initializeApp();

  Gemini.init(apiKey: "--your-api-key--");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Learner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Judson",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}
