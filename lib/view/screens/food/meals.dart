// ignore_for_file: must_be_immutable

import '../../../library.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String uid = arguments[0];
    final String docRef = arguments[1];
    final String index = arguments[2];
    final String mealName = arguments[3];

    return GetBuilder<MealsController>(
      init: MealsController(),
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
              mealName.toUpperCase(),
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
          extendBodyBehindAppBar: true,
          floatingActionButton: FloatingActionButton.extended(
            label: Text(
              PublicConstants.CREATE,
              style: Get.textTheme.headlineMedium,
            ),
            icon: Icon(EvaIcons.fileAdd,
                color: Get.theme.iconButtonTheme.style!.iconColor!.resolve({})),
            backgroundColor: Get.theme.primaryColor,
            onPressed: () {
              Get.toNamed(
                RoutesConstants.CREATEMEALPAGE,
                arguments: [arguments[2], arguments[1]],
              );
            },
          ),
          body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .collection('food')
                  .doc(docRef)
                  .collection(index)
                  .orderBy('isEated', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (controller.viewIndex == 0) {
                    return PageView.builder(
                      // shrinkWrap: false,
                      itemCount: snapshot.data!.docs.length,

                      itemBuilder: (ctx, i) {
                        DocumentSnapshot doc = snapshot.data!.docs[i];
                        DocumentReference<Map<String, dynamic>> mealDocRef =
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .collection('food')
                                .doc(docRef)
                                .collection(index)
                                .doc(doc['mealName']);

                        return Padding(
                          padding: EdgeInsets.only(
                            left: 30.w,
                            right: 30.w,
                            top: 270.h,
                            bottom: 270.h,
                          ),
                          child: MealsChildWidget(
                            mealDocRef: mealDocRef,
                            doc: doc,
                            controllerIndex: controller.viewIndex,
                          ),
                        );
                      },
                    );
                  } else if (controller.viewIndex == 1) {
                    return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, crossAxisSpacing: .1),
                      shrinkWrap: false,
                      itemBuilder: (ctx, i) {
                        DocumentSnapshot doc = snapshot.data!.docs[i];
                        DocumentReference<Map<String, dynamic>> mealDocRef =
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .collection('food')
                                .doc(docRef)
                                .collection(index)
                                .doc(doc['mealName']);
                        return MealsChildWidget(
                          mealDocRef: mealDocRef,
                          doc: doc,
                          controllerIndex: controller.viewIndex,
                        );
                      },
                    );
                  } else {
                    return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              childAspectRatio: .9),
                      shrinkWrap: false,
                      itemBuilder: (ctx, i) {
                        DocumentSnapshot doc = snapshot.data!.docs[i];
                        DocumentReference<Map<String, dynamic>> mealDocRef =
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .collection('food')
                                .doc(docRef)
                                .collection(index)
                                .doc(doc['mealName']);
                        return MealsChildWidget(
                          mealDocRef: mealDocRef,
                          doc: doc,
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
          ),
        );
      },
    );
  }
}

class MealsChildWidget extends StatelessWidget {
  MealsChildWidget({
    super.key,
    required this.mealDocRef,
    required this.controllerIndex,
    required this.doc,
  });

  final DocumentReference<Map<String, dynamic>> mealDocRef;
  final DocumentSnapshot<Object?> doc;
  int controllerIndex;

  @override
  Widget build(BuildContext context) {
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          QFButton(
                            onTap: () =>
                                mealDocRef.delete().then((value) => Get.back()),
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
      child: BlurredContainer(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.w),
        begin: Alignment.bottomLeft,
        borderRadius: BorderRadius.circular(20.r),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image(
                  image: CachedNetworkImageProvider(
                    doc['mealImage'],
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Get.theme.primaryColor,
                      ),
                    );
                  },
                  filterQuality: FilterQuality.high,
                  fit: controllerIndex == 2 ? BoxFit.fill : BoxFit.contain,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Text(doc['mealName'], style: Get.textTheme.headlineMedium),
            ),
            Visibility(
              visible: controllerIndex == 2 ? false : true,
              child: Divider(
                thickness: 1,
                color: Get.theme.primaryColor.withOpacity(.1),
              ),
            ),
            Visibility(
              visible: controllerIndex == 2 ? false : true,
              child: Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: RowedText(
                      child: Text(
                        doc['mealIngredients'],
                        style: Get.textTheme.headlineMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
