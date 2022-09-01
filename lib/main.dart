import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:posta/AppNavigator.dart';
import 'package:posta/View/MainScreen.dart';
import 'package:provider/provider.dart';

void main () async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppNavigator()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    ),
  ));
}