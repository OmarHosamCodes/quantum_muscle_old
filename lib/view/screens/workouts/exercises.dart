// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import '../../../library.dart';

class ExercisesPage extends HookWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String uid = arguments[0];
    final String docRef = arguments[1];
    final String index = arguments[2];
    final String workoutName = arguments[3];

    return GetBuilder<WorkoutsController>(
      init: WorkoutsController(),
      autoRemove: false,
      builder: (controller) {
        Widget viewIcon() {
          if (controller.viewIndex == 0) {
            return Icon(
              EvaIcons.swap,
              color: Get.theme.iconTheme.color,
            );
          } else if (controller.viewIndex == 1) {
            return Icon(
              EvaIcons.menu,
              color: Get.theme.iconTheme.color,
            );
          } else {
            return Icon(
              EvaIcons.keypad,
              color: Get.theme.iconTheme.color,
            );
          }
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                EvaIcons.arrowLeft,
                color: Get.theme.iconTheme.color,
              ),
            ),
            title: Text(
              workoutName.toUpperCase(),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => controller.changeView(),
                icon: viewIcon(),
              ),
            ],
          ),
          extendBody: true,
          extendBodyBehindAppBar: false,
          floatingActionButton: FloatingActionButton.extended(
            label: Text(
              PublicConstants.CREATE,
              style: Get.textTheme.titleMedium,
            ),
            icon: Icon(
              EvaIcons.fileAdd,
              color: Get.theme.iconButtonTheme.style!.iconColor!.resolve({}),
            ),
            backgroundColor: Get.theme.primaryColor,
            onPressed: () {
              Get.toNamed(
                RoutesConstants.CREATEEXERCISEPAGE,
                arguments: [arguments[2], arguments[1]],
              );
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
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (controller.viewIndex == 0) {
                  return PageView.builder(
                    itemCount: snapshot.data!.docs.length,
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
                        padding: EdgeInsets.only(
                          left: 50.w,
                          right: 50.w,
                          top: 50.h,
                          bottom: 50.h,
                        ),
                        child: WorkoutsChildWidget(
                          setsDocRef: setsDocRef,
                          doc: doc,
                          sets: sets,
                          setsMap: setsMap,
                          controllerIndex: controller.viewIndex,
                        ),
                      );
                    },
                  );
                } else if (controller.viewIndex == 1) {
                  return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    padding: EdgeInsets.only(
                      left: 50.w,
                      right: 50.w,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, mainAxisSpacing: 10),
                    shrinkWrap: false,
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
                      return WorkoutsChildWidget(
                        setsDocRef: setsDocRef,
                        doc: doc,
                        sets: sets,
                        setsMap: setsMap,
                        controllerIndex: controller.viewIndex,
                      );
                    },
                  );
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    padding: EdgeInsets.only(
                      left: 50.w,
                      right: 50.w,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            childAspectRatio: .9),
                    shrinkWrap: false,
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
                      return WorkoutsChildWidget(
                        setsDocRef: setsDocRef,
                        doc: doc,
                        sets: sets,
                        setsMap: setsMap,
                        controllerIndex: controller.viewIndex,
                      );
                    },
                  );
                }
              } else if (!snapshot.hasData) {
                return const Center(child: Text(PublicConstants.NODATA));
              } else {
                return const Center(child: QFProgressIndicator());
              }
            },
          ),
        );
      },
    );
  }
}

class WorkoutsChildWidget extends HookWidget {
  WorkoutsChildWidget({
    super.key,
    required this.setsDocRef,
    required this.doc,
    required this.sets,
    required this.setsMap,
    required this.controllerIndex,
  });
  final DocumentReference<Map<String, dynamic>> setsDocRef;
  final DocumentSnapshot<Object?> doc;
  List<String> sets;
  Map<String, String> setsMap;
  int controllerIndex;

  @override
  Widget build(BuildContext context) {
    final repsController = useTextEditingController();
    final weightsController = useTextEditingController();
    return GestureDetector(
      onLongPress: () {
        Get.bottomSheet(
            BottomSheet(
              elevation: 0,
              backgroundColor: Colors.transparent,
              onClosing: () {},
              builder: (context) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70.r),
                    topRight: Radius.circular(70.r),
                  ),
                  color: Get.theme.primaryColor.withOpacity(.3),
                ),
                child: SizedBox(
                  height: 400.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        PublicConstants.CONFIRMDELETE,
                        style: Get.textTheme.headlineMedium,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QFButton(
                            onTap: () =>
                                setsDocRef.delete().then((value) => Get.back()),
                            child: Text(
                              PublicConstants.DELETE,
                              style: Get.textTheme.headlineMedium,
                            ),
                          ),
                          QFButton(
                            isAnotherOption: true,
                            onTap: () => Get.back(),
                            child: Text(
                              PublicConstants.CANCEL,
                              style: Get.textTheme.headlineMedium,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0);
      },
      child: Container(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey, width: 3.0),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            doc['exerciseImage'] != null
                ? Flexible(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15).r,
                      child: Image(
                        width: double.maxFinite,
                        image: CachedNetworkImageProvider(
                          doc['exerciseImage'],
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return SizedBox(
                            height: 500.h,
                            width: 500.w,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Get.theme.primaryColor,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => SizedBox(
                          height: 500.h,
                          width: 500.w,
                          child: Center(
                            child: Text(
                              "Error while uploading",
                              style: Get.textTheme.titleMedium,
                            ),
                          ),
                        ),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Flexible(
                    flex: 3,
                    child: Placeholder(
                      fallbackHeight: 500.h,
                      fallbackWidth: 500.w,
                    ),
                  ),
            SizedBox(height: 30.h),
            Flexible(
              flex: 1,
              child: controllerIndex == 2
                  ? FittedBox(
                      child: Text(
                        doc['exerciseName'],
                        style: Get.textTheme.titleLarge,
                      ),
                    )
                  : Text(
                      doc['exerciseName'],
                      style: Get.textTheme.titleLarge,
                    ),
            ),
            Visibility(
              visible: controllerIndex == 2 ? false : true,
              child: Flexible(
                flex: 1,
                child: Text(
                  "${doc['exerciseTarget']}",
                  style: Get.textTheme.titleSmall,
                ),
              ),
            ),
            const Spacer(),
            Visibility(
              visible: controllerIndex == 2 ? false : true,
              child: Flexible(
                flex: 2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sets.length,
                  itemBuilder: (setsContext, setsIndex) {
                    BorderRadius _borderRadius() {
                      if (setsIndex == 0) {
                        return BorderRadius.only(
                          bottomLeft: Radius.circular(20.r),
                          // topLeft: Radius.circular(20.r),
                        );
                      } else if (setsIndex == sets.length - 1) {
                        return BorderRadius.only(
                          bottomRight: Radius.circular(20.r),
                          // topRight: Radius.circular(20.r),
                        );
                      } else {
                        return BorderRadius.circular(0).r;
                      }
                    }

                    CrossAxisAlignment _crossAxisAlignment() {
                      if (setsIndex == 0) {
                        return CrossAxisAlignment.start;
                      } else if (setsIndex == sets.length - 1) {
                        return CrossAxisAlignment.end;
                      } else {
                        return CrossAxisAlignment.center;
                      }
                    }

                    Text _setsNumber() {
                      if (setsIndex == 0) {
                        return const Text("1");
                      } else if (setsIndex == sets.length - 1) {
                        return Text("${sets.length}");
                      } else {
                        return const Text("");
                      }
                    }

                    Color _containerColor() {
                      if (setsIndex == 0) {
                        return Get.theme.canvasColor;
                      } else if (setsIndex == sets.length - 1) {
                        return Get.theme.canvasColor;
                      } else {
                        return Colors.transparent;
                      }
                    }

                    return Column(
                      crossAxisAlignment: _crossAxisAlignment(),
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5.0,
                                right: 5.0,
                                top: 5.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: _containerColor(),
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(15).r,
                                      topRight: const Radius.circular(15).r,
                                    )),
                                height: 100.h,
                                width: 100.w,
                                child: FittedBox(
                                  child: Align(
                                    widthFactor: 1.2,
                                    alignment: Alignment.center,
                                    child: _setsNumber(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
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
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  ExercisesConstants.ENTERINFO,
                                                  style: Get
                                                      .textTheme.headlineMedium,
                                                ),
                                                SizedBox(
                                                  height: 30.h,
                                                ),
                                                QFTextField(
                                                  controller: weightsController,
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
                                                  height: 25.h,
                                                ),
                                                QFButton(
                                                  child: Text(
                                                    PublicConstants.SAVE,
                                                    style: Get.textTheme
                                                        .headlineMedium,
                                                  ),
                                                  onTap: () async {
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
                                                        repsController.clear();
                                                      });
                                                    } catch (e) {
                                                      Get.snackbar(
                                                          "Network Error", '',
                                                          duration:
                                                              100.milliseconds);
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5.0,
                                  right: 5.0,
                                  bottom: 5.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Get.theme.canvasColor,
                                    borderRadius: _borderRadius(),
                                  ),
                                  height: 160.h,
                                  width: 224.w,
                                  child: FittedBox(
                                    child: Align(
                                      widthFactor: 1.2,
                                      alignment: Alignment.center,
                                      child: Text(
                                        sets[setsIndex],
                                        style: Get.textTheme.titleLarge,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
