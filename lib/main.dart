import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posta/AppNavigator.dart';
import 'package:posta/View/MainScreen.dart';
import 'package:provider/provider.dart';

void main ()
{
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