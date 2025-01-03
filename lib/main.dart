import 'package:firebase_core/firebase_core.dart';
import 'package:first_aid_pro_app/Model/wound_models/wound_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'screen/auth/login.dart';
import 'screen/landing_page.dart';
import 'services/img_upload_repo.dart';
import 'services/repository.dart';
import 'services/wound_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  print("Opening Hive box...");
  await Hive.openBox<Wound>('wounds_box');
  print("Hive box opened.");

  Hive.registerAdapter(WoundAdapter());
  runApp(RepositoryProvider(
    create: (context) => Repository(
      imageUploadViewModelRepo: ImageUploadViewModelRepo(),
    ),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: SelectableText('Error: ${snapshot.error.toString()}'),
              ),
            ),
          );
        }

        return ChangeNotifierProvider<WoundService>(
          create: (context) => WoundService(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Aid Pro',
            theme: ThemeData(
              useMaterial3: true, 
              fontFamily: 'SFRegular',
              primarySwatch: Colors.red,
              scaffoldBackgroundColor: Colors.white,
            ),
            home: const LandingPage(),
          ),
        );
      },
    );
  }
}