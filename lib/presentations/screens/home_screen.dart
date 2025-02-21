import 'package:fit_lovers/presentations/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Home Screen',
      ),
      body: Center(child: Text('Home Screen')),
    );
  }
}
