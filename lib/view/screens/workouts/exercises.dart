// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable

import '../../../library.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String uid = arguments[0];
    final String docRef = arguments[1];
    final String index = arguments[2];
    final String workoutName = arguments[3];

    return GetBuilder<ExerciseContrller>(
      init: ExerciseContrller(),
      autoRemove: false,
      builder: (controller) {
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
                icon: controller.viewIcon(),
              ),
            ],
          ),
          extendBody: true,
          extendBodyBehindAppBar: false,
          resizeToAvoidBottomInset: false,
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
          body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection('workouts')
                .doc(docRef)
                .collection(index)
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
                              .collection(i.toString())
                              .doc(doc['exerciseName']);
                      Map<String, String> setsMap =
                          doc['sets'].cast<String, String>();
                      List<String> sets = setsMap.values.toList();

                      return Padding(
                        padding: EdgeInsets.only(
                          left: 50.w,
                          right: 50.w,
                          top: 250.h,
                          bottom: 250.h,
                        ),
                        child: WorkoutsChildWidget(
                          setsDocRef: setsDocRef,
                          doc: doc,
                          sets: sets,
                          setsMap: setsMap,
                          controllerIndex: controller.viewIndex,
                          controller: controller,
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
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      childAspectRatio: .7,
                    ),
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
                        controller: controller,
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
                            childAspectRatio: .75),
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
                        controller: controller,
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
    required this.controller,
  });
  final DocumentReference<Map<String, dynamic>> setsDocRef;
  final DocumentSnapshot<Object?> doc;
  List<String> sets;
  Map<String, String> setsMap;
  int controllerIndex;
  ExerciseContrller controller;

  @override
  Widget build(BuildContext context) {
    final repsController = useTextEditingController();
    final weightsController = useTextEditingController();

    return Container(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey, width: 3.0),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
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
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                    Placeholder(
                  fallbackHeight: 500.h,
                  fallbackWidth: 500.w,
                  child: child,
                ),
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            flex: 2,
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
            visible: controller.visibiltyIndexCondition,
            child: Flexible(
              flex: 1,
              child: Text(
                "${doc['exerciseTarget']}",
                style: Get.textTheme.titleSmall,
              ),
            ),
          ),
          // const Spacer(),
          Visibility(
            visible: controller.visibiltyIndexCondition,
            child: Flexible(
              flex: 2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sets.length,
                itemBuilder: (setsContext, setsIndex) {
                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      crossAxisAlignment:
                          controller.crossAxisAlignment(setsIndex, sets),
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5.0,
                                right: 5.0,
                                top: 5.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: controller.containerColor(
                                    setsIndex,
                                    sets,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(15).r,
                                    topRight: const Radius.circular(15).r,
                                  ),
                                ),
                                height: 100.h,
                                width: 100.w,
                                child: FittedBox(
                                  child: Align(
                                    widthFactor: 1.2,
                                    alignment: Alignment.center,
                                    child: controller.setsNumberText(
                                        setsIndex, sets),
                                  ),
                                ),
                              ),
                            ),
                            controller.addOneRep(1, setsIndex, sets, setsDocRef)
                          ],
                        ),
                        // const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => controller.changeRepSheet(
                                setsDocRef,
                                repsController,
                                weightsController,
                                setsIndex,
                                controller,
                                setsMap,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5.0,
                                  right: 5.0,
                                  bottom: 5.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Get.theme.canvasColor,
                                    borderRadius: controller.borderRadius(
                                        sets, setsIndex),
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
                            controller.addOneRep(
                                0, setsIndex, sets, setsDocRef),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                visible: controller.visibiltyIndexCondition,
                child: GestureDetector(
                  onTap: () {
                    final content = jsonEncode(doc.data());
                    controller.shareExercise(content);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.w, bottom: 70.h),
                    child: const Icon(
                      EvaIcons.share,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: controller.visibiltyIndexCondition,
                child: GestureDetector(
                  onTap: () => controller.deleteExerciseSheet(setsDocRef),
                  child: Padding(
                    padding: EdgeInsets.only(right: 30.w, bottom: 70.h),
                    child: const Icon(
                      EvaIcons.trash,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
