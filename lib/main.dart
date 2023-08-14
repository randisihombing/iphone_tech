import 'package:flutter/material.dart';
import 'package:iphone_technical/provider/iphone_provider.dart';
import 'package:iphone_technical/splash_screen.dart';
import 'package:provider/provider.dart';

import 'add_data/add_data.dart';
import 'data_list_screen/data_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
       MaterialApp(
        title: 'Todo List',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (ctx) => const SplashScreen(),
          '/submit': (ctx) => const SubmitDataScreen(),
          '/dataList': (ctx) => const DataListScreen(),
        });

    //   MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'My To Do List',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: SplashScreen(),
    // );
  }
}