import 'package:as_news/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Get.to(() => HomePage(),
                    transition: Transition.cupertino,
                    duration: Duration(seconds: 3),
                    opaque: true);
              },
              child: Text("Go to Home"))
        ],
      ),
    );
  }
}
