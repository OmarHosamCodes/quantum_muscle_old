import 'package:flutter_animate/flutter_animate.dart';
import '../../../library.dart';

class WorkoutsPage extends HookWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutNameController = useTextEditingController();
    User? user = FirebaseAuth.instance.currentUser;
    final controller = WorkoutsController();
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
                      controller.createWorkout(workoutNameController.text);
                      workoutNameController.clear();
                    },
                    text: PublicConstants.CREATE),
              ],
            ),
          ),
        ),
        child: const Icon(EvaIcons.plus),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .collection('workouts')
              .orderBy('isPinned', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, i) {
                  DocumentSnapshot doc = snapshot.data!.docs[i];

                  return GetBuilder<WorkoutsController>(
                    init: WorkoutsController(),
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () => Get.toNamed(
                          RoutesConstants.EXERCISESPAGE,
                          arguments: [
                            user.uid,
                            doc.reference.id,
                            i.toString(),
                          ],
                        ),
                        onLongPress: () => controller.expandContainer(),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 30.h),
                          child: AnimatedContainer(
                            duration: GetNumUtils(300).milliseconds,
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            width: double.infinity,
                            height: controller.containerHeight,
                            decoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      doc['workoutName'],
                                      style: Get.textTheme.headlineMedium,
                                    ),
                                    const Spacer(),
                                    doc['isPinned']
                                        ? Icon(
                                            EvaIcons.pinOutline,
                                            size: 50.w,
                                          )
                                        : Container(),
                                    const Icon(
                                      EvaIcons.arrowRight,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: controller.isContainerExpanded,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      QFButton(
                                        onTap: () => controller
                                            .deleteWorkout(doc['workoutName']),
                                        child: const Icon(EvaIcons.trash),
                                      ),
                                      QFButton(
                                        onTap: () => doc['isPinned']
                                            ? controller.pinWorkoutTofalse(
                                                doc['workoutName'])
                                            : controller.pinWorkoutToTrue(
                                                doc['workoutName']),
                                        child: Icon(
                                          EvaIcons.pinOutline,
                                          size: 50.w,
                                        ),
                                      ),
                                    ],
                                  ).animate().fadeIn(
                                      delay: GetNumUtils(50).milliseconds),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text(PublicConstants.NODATA));
            } else {
              return const Center(child: QFProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
