import '/library.dart';

class ExerciseContrller extends GetxController {
  final getStorage = GetStorage();
  final firebaseFirestore = FirebaseFirestore.instance;
  int viewIndex = 0;
  final storageKey = ('workoutsView');
  bool visibiltyIndexCondition = true;

  BorderRadius borderRadius(List<String> sets, int setsIndex) {
    if (setsIndex == 0) {
      return BorderRadius.only(
        bottomLeft: Radius.circular(20.r),
      );
    } else if (setsIndex == sets.length - 1) {
      return BorderRadius.only(
        bottomRight: Radius.circular(20.r),
      );
    } else {
      return BorderRadius.circular(0).r;
    }
  }

  Future<void> changeRep(
    DocumentReference<Map<String, dynamic>> setsDocRef,
    TextEditingController repsController,
    TextEditingController weightsController,
    int setsIndex,
    Map<String, String> setsMap,
  ) async {
    try {
      final toUpdate = {
        'sets': {
          setsMap.keys.elementAt(setsIndex).toString():
              "${weightsController.text} x ${repsController.text}",
        }
      };
      await setsDocRef
          .set(
        toUpdate,
        SetOptions(
          merge: true,
        ),
      )
          .whenComplete(() {
        Get.back();
        weightsController.clear();
        repsController.clear();
      });
    } catch (e) {
      Get.rawSnackbar(
        title: PublicConstants.ERROR,
        message: e.toString(),
      );
    }
  }

  Future<void> deleteRep(
    DocumentReference<Map<String, dynamic>> setsDocRef,
    int setsIndex,
    Map<String, String> setsMap,
  ) async {
    try {
      final toUpdate = {
        "sets": {"$setsIndex": FieldValue.delete()}
      };

      setsDocRef.set(
        toUpdate,
        SetOptions(
          merge: true,
        ),
      );
      Get.back();
    } catch (e) {
      Get.rawSnackbar(
        title: PublicConstants.ERROR,
        message: e.toString(),
      );
    }
  }

  void changeRepSheet(
    DocumentReference<Map<String, dynamic>> setsDocRef,
    TextEditingController repsController,
    TextEditingController weightsController,
    int setsIndex,
    ExerciseContrller controller,
    Map<String, String> setsMap,
  ) {
    Get.bottomSheet(
      BottomSheet(
        backgroundColor: Colors.transparent,
        onClosing: () {},
        builder: (setsContext) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70.r),
              color: Get.theme.canvasColor.withOpacity(.9),
            ),
            child: SizedBox(
              height: 800.h,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ExercisesConstants.ENTERINFO,
                    style: Get.textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  QFTextField(
                    controller: weightsController,
                    hintText: ExercisesConstants.WEIGHTS,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 25.h),
                  QFTextField(
                    controller: repsController,
                    hintText: ExercisesConstants.REPS,
                    hasNext: false,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QFButton(
                        child: Text(
                          PublicConstants.SAVE,
                          style: Get.textTheme.titleMedium,
                        ),
                        onTap: () async {
                          controller.changeRep(setsDocRef, repsController,
                              weightsController, setsIndex, setsMap);
                        },
                      ),
                      QFButton(
                        isAnotherOption: true,
                        child: Text(
                          PublicConstants.DELETE,
                          style: Get.textTheme.titleMedium!
                              .copyWith(color: Colors.red.shade400),
                        ),
                        onTap: () => controller.deleteRep(
                          setsDocRef,
                          setsIndex,
                          setsMap,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Future changeView() async {
    getStorage.write(storageKey, (viewIndex + 1) % 3);
    viewIndex = await getStorage.read(storageKey);
    visibiltyIndexCondition = viewIndex == 2 ? false : true;
    update();
  }

  Color containerColor(int setsIndex, List<String> sets) {
    if (setsIndex == 0) {
      return Get.theme.canvasColor;
    } else if (setsIndex == sets.length - 1) {
      return Get.theme.canvasColor;
    } else {
      return Colors.transparent;
    }
  }

  CrossAxisAlignment crossAxisAlignment(int setsIndex, List<String> sets) {
    if (setsIndex == 0) {
      return CrossAxisAlignment.start;
    } else if (setsIndex == sets.length - 1) {
      return CrossAxisAlignment.end;
    } else {
      return CrossAxisAlignment.center;
    }
  }

  Widget addOneRep(
    int priority,
    int setsIndex,
    List<String> sets,
    DocumentReference<Map<String, dynamic>> setsDocRef,
  ) {
    if (setsIndex == sets.length - 1) {
      if (priority == 0) {
        return SizedBox(
          // height: 160.h,
          width: 224.w,
          child: GestureDetector(
            onTap: () async {
              await setsDocRef.set(
                {
                  'sets': {
                    sets.length.toString(): "",
                  },
                },
                SetOptions(
                  merge: true,
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      } else {
        return SizedBox(
          width: 224.w,
        );
      }
    } else {
      return const Center();
    }
  }

  Text setsNumberText(int setsIndex, List<String> sets) {
    if (setsIndex == 0) {
      return const Text("1");
    } else if (setsIndex == sets.length - 1) {
      return Text("${sets.length}");
    } else {
      return const Text("");
    }
  }

  Widget viewIcon() {
    if (viewIndex == 0) {
      return Icon(
        EvaIcons.swap,
        color: Get.theme.iconTheme.color,
      );
    } else if (viewIndex == 1) {
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

  void deleteExerciseSheet(
    DocumentReference<Map<String, dynamic>> setsDocRef,
  ) {
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
            color: Get.theme.canvasColor.withOpacity(.9),
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
                  style: Get.textTheme.titleMedium,
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
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: Colors.red.shade400),
                      ),
                    ),
                    QFButton(
                      isAnotherOption: true,
                      onTap: () => Get.back(),
                      child: Text(
                        PublicConstants.CANCEL,
                        style: Get.textTheme.titleMedium,
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
      elevation: 0,
    );
  }

  Future<void> shareExercise(String content) async {
    await Share.share(
      content,
    );
  }
}
