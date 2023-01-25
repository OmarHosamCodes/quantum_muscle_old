import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
  FirebaseAuth firebaseAuthInstants = FirebaseAuth.instance;
    return Scaffold(
     body: Center(
      child: GestureDetector(
        onTap: ()=> firebaseAuthInstants.signOut().whenComplete(() => Get.back(canPop: false)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Text(firebaseAuthInstants.currentUser!.email!),
            Text(firebaseAuthInstants.currentUser!.uid),
          ],
        ),
      ),
     ),
   );
  }
}