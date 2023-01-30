import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/text_constants.dart';
import 'package:quantum_muscle/view/screens/workouts/create_exercise.dart';
import 'package:quantum_muscle/view/widgets/public/progress_indicator_widget.dart';
import 'package:quantum_muscle/view/widgets/public/text_field_widget.dart';
import '../../widgets/public/rowed_text_widget.dart';

class ExercisesPage extends HookWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repsController = useTextEditingController();
    final weightsController = useTextEditingController();
    final arguments = Get.arguments;
    final String uid = arguments[0];
    final String docRef = arguments[1];
    final String index = arguments[2];

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          ExercisesConstants.CREATE,
          style: Get.textTheme.titleMedium,
        ),
        backgroundColor: Get.theme.primaryColor,
        onPressed: () {
          Get.to(const CreateWorkoutPage(),
              arguments: [arguments[2], arguments[1]],
              transition: Transition.fade);
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('workouts')
            .doc(docRef)
            .collection(index)
            .orderBy('timeNow', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 30,
              ),
              shrinkWrap: false,
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, mainAxisExtent: 500),
              itemBuilder: (ctx, i) {
                DocumentSnapshot doc = snapshot.data!.docs[i];
                DocumentReference<Map<String, dynamic>> setsDocRef =
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('workouts')
                        .doc(docRef)
                        .collection(index)
                        .doc(doc['exerciseName']);

                Map<String, String> setsMap =
                    doc['sets'].cast<String, String>();
                List<String> sets = setsMap.values.toList();

                return Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 1000 / 700,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: doc['exerciseImage'] != null
                                ? Image.network(
                                    doc['exerciseImage'],
                                    height: 250.h,
                                    width: 250.w,
                                    cacheHeight: 250.h.toInt(),
                                    cacheWidth: 250.w.toInt(),
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.contain,
                                  )
                                : Placeholder(
                                    fallbackHeight: 250.h,
                                    fallbackWidth: 300.w,
                                  ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        RowedText(
                          child: Text(
                            doc['exerciseName'],
                            style: Get.textTheme.headlineMedium,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        RowedText(
                          child: Text(
                            doc['exerciseTarget'],
                            style: Get.textTheme.headlineMedium,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sets.length,
                            itemBuilder: (setsContext, setsIndex) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      BottomSheet(
                                        backgroundColor: Colors.transparent,
                                        onClosing: () {},
                                        builder: (setsContext) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(70.r),
                                              color: Get.theme.primaryColor
                                                  .withOpacity(.3),
                                            ),
                                            child: SizedBox(
                                              height: 800.h,
                                              width: 500.w,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    ExercisesConstants
                                                        .ENTERINFO,
                                                    style: Get.textTheme
                                                        .headlineMedium,
                                                  ),
                                                  SizedBox(
                                                    height: 30.h,
                                                  ),
                                                  QFTextField(
                                                    controller:
                                                        weightsController,
                                                    hintText: ExercisesConstants
                                                        .WEIGHTS,
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                  SizedBox(height: 25.h),
                                                  QFTextField(
                                                    controller: repsController,
                                                    hintText:
                                                        ExercisesConstants.REPS,
                                                    hasNext: false,
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  MaterialButton(
                                                    child: Text(
                                                      ExercisesConstants.SAVE,
                                                      style: Get.textTheme
                                                          .headlineMedium,
                                                    ),
                                                    onPressed: () async {
                                                      final update = {
                                                        'sets': {
                                                          setsMap.keys
                                                                  .elementAt(
                                                                      setsIndex)
                                                                  .toString():
                                                              "${weightsController.text} x ${repsController.text}",
                                                        }
                                                      };

                                                      try {
                                                        await setsDocRef
                                                            .set(
                                                          update,
                                                          SetOptions(
                                                            merge: true,
                                                          ),
                                                        )
                                                            .whenComplete(() {
                                                          Get.back();
                                                          weightsController
                                                              .clear();
                                                          repsController
                                                              .clear();
                                                        });
                                                      } catch (e) {
                                                        Get.snackbar(
                                                            "Network Error", '',
                                                            duration: 100
                                                                .milliseconds);
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      color: Get.theme.scaffoldBackgroundColor
                                          .withOpacity(.1),
                                      height: 160.h,
                                      width: 224.w,
                                      child: FittedBox(
                                        child: Align(
                                          widthFactor: 1.2,
                                          alignment: Alignment.center,
                                          child: Text(
                                            sets[setsIndex],
                                            style: Get.textTheme.headlineSmall,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text(PublicConstants.NODATA));
          } else {
            return const Center(child: QFProgressIndicator());
          }
        },
      ),
    );
  }
}
