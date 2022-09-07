import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() {
  runApp(const MyAPP());
}

class MyAPP extends StatelessWidget {
  const MyAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Tema do Aplicativo
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //Chama página principal
      home: const HomePage(),
    );
  }
}
