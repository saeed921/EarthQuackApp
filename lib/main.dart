import 'package:earthquack_apps_by_rest_api/pages/earthquake_page.dart';
import 'package:earthquack_apps_by_rest_api/providers/eq_data_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context)=> EarthquakeProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
initialRoute: EarthQuakePage.routeName,
      routes: {
        EarthQuakePage.routeName:(context)=>EarthQuakePage(),
      },
    );
  }
}

