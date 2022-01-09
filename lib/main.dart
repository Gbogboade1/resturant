import 'package:flutter/material.dart';
import 'package:resturant_video/providers/cart_provider.dart';
import 'package:resturant_video/providers/display_provider.dart';
import 'package:resturant_video/screens/dash_board_page.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => CartProvider()),
        Provider(create: (context) => AppDisplayProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Resturant',
      debugShowCheckedModeBanner: false,
      home: DashBoardPage(),
    );
  }
}
