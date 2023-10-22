import '../../../library.dart';

class IntentPage extends StatelessWidget {
  const IntentPage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final arguments = Get.arguments;
    final sharedText = arguments[0];
    return GetBuilder<IntentController>(
      autoRemove: false,
      init: IntentController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .collection('workouts')
                  .orderBy('isPinned', descending: true)
                  .get(),
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

                      return GestureDetector(
                        onTap: () => controller.addToWorkout(
                          doc['workoutName'],
                          i.toString(),
                          sharedText,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 30.h),
                          child: AnimatedContainer(
                            duration: GetNumUtils(300).milliseconds,
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            width: double.infinity,
                            height: 200.h,
                            decoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  doc['workoutName'],
                                  style: Get.textTheme.titleSmall,
                                ),
                                const Spacer(),
                                Icon(
                                  EvaIcons.plus,
                                  color: Get.textTheme.titleLarge!.color,
                                ),
                              ],
                            ),
                          ),
                        ),
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
      },
    );
  }
}
