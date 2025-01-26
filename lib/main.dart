import 'package:flutter/material.dart';
import 'package:invest_sakhi/screens/home_screen.dart';
import 'package:invest_sakhi/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xff03A5E1))
            .copyWith(background: const Color(0xffF6F6F6)),
      ),
      home: HomeScreen(),
    );
  }
}
