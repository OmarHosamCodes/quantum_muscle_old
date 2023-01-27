// ignore_for_file: must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/routes_constants.dart';
import 'package:quantum_muscle/constants/text_constants.dart';
import 'package:quantum_muscle/controller/workouts/workouts_controller.dart';
import 'package:quantum_muscle/view/widgets/private/auth/auth_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutsPage extends HookWidget {
  WorkoutsPage({super.key});
  final workoutNameController = TextEditingController();
  final controller = WorkoutsController();
  User? user = FirebaseAuth.instance.currentUser;

  List<String> docIDs = [];
  Future getDocId() async {
    docIDs.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('workouts')
        .get()
        .then(
          (snapshot) => snapshot.docs
              .forEach((document) => docIDs.add(document.reference.id)),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.dialog(
          barrierDismissible: false,
          Dialog(
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                QFTextField(
                  controller: workoutNameController,
                  hintText: WorkoutsConstants.WORKOUTNAME,
                  obscureText: false,
                  hasNext: false,
                ),
                SizedBox(
                  height: 30.h,
                ),
                QFButton(
                    onTap: () {
                      controller.createWorkout(workoutNameController.text);
                      Get.back();
                      workoutNameController.clear();
                      getDocId();
                    },
                    text: WorkoutsConstants.CREATE),
              ],
            ),
          ),
        ),
        backgroundColor: Get.theme.primaryColor,
        child: const Icon(EvaIcons.plus),
      ),
      body: FutureBuilder(
        future: getDocId(),
        builder: (context, snapshot) => GridView.builder(
          shrinkWrap: true,
          itemCount: docIDs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h),
          itemBuilder: (ctx, i) {
            return SafeArea(
              child: GestureDetector(
                onTap: () => Get.toNamed(RoutesConstants.exercisesPage),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        docIDs[i],
                        style: Get.textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
