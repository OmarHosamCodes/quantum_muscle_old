// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/text_constants.dart';
import 'package:quantum_muscle/controller/workouts/workouts_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quantum_muscle/view/widgets/public/progress_indicator_widget.dart';

import '../../widgets/public/button_widget.dart';
import '../../widgets/public/text_field_widget.dart';
import 'exercises.dart';

class WorkoutsPage extends StatelessWidget {
  WorkoutsPage({super.key});
  final workoutNameController = TextEditingController();
  final controller = WorkoutsController();
  User? user = FirebaseAuth.instance.currentUser;

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
                    onTap: () async {
                      controller.createWorkout(workoutNameController.text, 0);
                      Get.back();
                      workoutNameController.clear();
                    },
                    text: WorkoutsConstants.CREATE),
              ],
            ),
          ),
        ),
        backgroundColor: Get.theme.primaryColor,
        child: const Icon(EvaIcons.plus),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('workouts')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h),
              itemBuilder: (ctx, i) {
                DocumentSnapshot doc = snapshot.data!.docs[i];

                return SafeArea(
                  child: GestureDetector(
                    onTap: () => Get.to(() => const ExercisesPage(),
                        transition: Transition.fadeIn,
                        duration: 200.milliseconds,
                        arguments: [
                          user!.uid,
                          doc.reference.id,
                          i.toString(),
                        ]),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            doc.reference.id,
                            style: Get.textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text(PublicConstants.NODATA);
          } else {
            return const QFProgressIndicator();
          }
        },
      ),
    );
  }
}
