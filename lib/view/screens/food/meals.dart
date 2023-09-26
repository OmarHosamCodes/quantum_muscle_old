import '../../../library.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String uid = arguments[0];
    final String docRef = arguments[1];
    final String index = arguments[2];
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          PublicConstants.CREATE,
          style: Get.textTheme.headlineMedium,
        ),
        icon: const Icon(EvaIcons.fileAdd),
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
              return GridView.builder(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                shrinkWrap: false,
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, crossAxisSpacing: .1),
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

                  return GestureDetector(
                    onTap: () => mealDocRef
                        .update({"isEated": doc["isEated"] ? false : true}),
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
                                    QFButton(
                                      onTap: () => mealDocRef.delete(),
                                      child: Text(
                                        PublicConstants.DELETE,
                                        style: Get.textTheme.headlineMedium,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0);
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 20.h,
                              ),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        doc['mealImage']),
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(doc['mealName'],
                                  style: Get.textTheme.headlineMedium),
                            ),
                          ),
                          Flexible(
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
      ),
    );
  }
}
