import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/text_constants.dart';
import 'package:quantum_muscle/controller/food/meal_group_controller.dart';

import '../../widgets/public/button_widget.dart';
import '../../widgets/public/progress_indicator_widget.dart';
import '../../widgets/public/text_field_widget.dart';

class MealGroupsPage extends HookWidget {
  const MealGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mealGroupNameController = useTextEditingController();
    User? user = FirebaseAuth.instance.currentUser;
    final controller = MealGroupController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        onPressed: () => Get.dialog(
            barrierDismissible: false,
            Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  QFTextField(
                    controller: mealGroupNameController,
                    hintText: MealsConstants.MEALGROUPNAME,
                    obscureText: false,
                    hasNext: false,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  QFButton(
                      onTap: () async {
                        controller
                            .createMealGroup(mealGroupNameController.text);
                        Get.back();
                        mealGroupNameController.clear();
                      },
                      text: PublicConstants.CREATE),
                ],
              ),
            )),
        child: const Icon(EvaIcons.plus),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .collection('food')
                .orderBy('isPinned', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, i) {
                      DocumentSnapshot doc = snapshot.data!.docs[i];

                      return GestureDetector(
                        onTap: () => Get.toNamed(
                          RoutesConstants.MEALSPAGE,
                          arguments: [
                            user.uid,
                            doc.reference.id,
                            i.toString(),
                          ],
                        ),
                        child: Slidable(
                          startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (ctx) => controller
                                      .deleteMealGroup(doc['mealGroupName']),
                                  backgroundColor: Colors.redAccent,
                                  icon: EvaIcons.trash,
                                )
                              ]),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (ctx) => doc['isPinned']
                                    ? controller.pinMealGroupTofalse(
                                        doc['mealGroupName'])
                                    : controller.pinMealGroupToTrue(
                                        doc['mealGroupName']),
                                backgroundColor: Colors.brown,
                                icon: EvaIcons.pin,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            width: double.infinity,
                            height: 200.h,
                            decoration: BoxDecoration(
                                color: Get.theme.primaryColor,
                                border: doc['isPinned']
                                    ? Border.all(
                                        width: 3, color: Colors.tealAccent)
                                    : null),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  doc['mealGroupName'],
                                  style: Get.textTheme.headlineMedium,
                                ),
                                const Icon(
                                  EvaIcons.arrowRight,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return const Center(child: Text(PublicConstants.NODATA));
              } else {
                return const Center(child: QFProgressIndicator());
              }
            }),
      ),
    );
  }
}
