import '../../../library.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  late final uid = firebaseAuth.currentUser!.uid;
  final heightTextController = TextEditingController();
  final weightTextController = TextEditingController();
  final bioTextController = TextEditingController();
  int heightAndWeightIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (controller) {
            return StreamBuilder(
                stream: firebaseFirestore
                    .collection('users')
                    .doc(uid)
                    .get()
                    .asStream(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic>? doc = snapshot.data!.data();
                    Map<String, String> heightMap =
                        doc!['userHeight'].cast<String, String>();
                    String height = heightMap.values.lastOrNull!;
                    heightAndWeightIndex = heightMap.length;
                    Map<String, String> weightMap =
                        doc['userWeight'].cast<String, String>();

                    String weight = weightMap.values.lastOrNull!;

                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                          bottom: 30,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: doc['userImage'] != null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () => controller.openDialog(
                                            controller,
                                            () => controller.openCamera(
                                                controller,
                                                ischangeUserImage: true),
                                            () => controller.openGallery(
                                                controller,
                                                ischangeUserImage: true),
                                          ),
                                          child: Container(
                                            width: 300.w,
                                            height: 300.h,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    CachedNetworkImageProvider(
                                                  doc['userImage'],
                                                ),
                                              ),
                                              border: Border.all(
                                                color: Get.theme.primaryColor,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 30.w),
                                        GestureDetector(
                                          onTap: () => controller
                                              .changeHeightAndWeightDialog(
                                                  controller,
                                                  heightTextController,
                                                  weightTextController,
                                                  heightAndWeightIndex),
                                          child: Text(
                                            "\n${doc['userName'].toString()}\nHeight: $height\nWeight: $weight\n",
                                            style: Get.textTheme.titleSmall,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () => controller.openDialog(
                                            controller,
                                            () => controller.openCamera(
                                                controller,
                                                ischangeUserImage: true),
                                            () => controller.openGallery(
                                                controller,
                                                ischangeUserImage: true),
                                          ),
                                          child: Container(
                                            width: 300.w,
                                            height: 300.h,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Get
                                                        .theme.primaryColor)),
                                            child: const Icon(EvaIcons.person),
                                          ),
                                        ),
                                        SizedBox(width: 30.w),
                                        GestureDetector(
                                          onTap: () => controller
                                              .changeHeightAndWeightDialog(
                                                  controller,
                                                  heightTextController,
                                                  weightTextController,
                                                  heightAndWeightIndex),
                                          child: Text(
                                            "\n${doc['userName'].toString()}\nHeight: $height\nWeight: $weight\n",
                                            style: Get.textTheme.titleSmall,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                            ),
                            Flexible(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () => controller.changeBioDialog(
                                    controller, bioTextController),
                                child: Container(
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25.w, vertical: 25.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Get.theme.primaryColor,
                                      width: 3.0,
                                    ),
                                    borderRadius: BorderRadius.circular(20).r,
                                  ),
                                  child: Text(
                                    "Bio: ${doc['userBio'].toString()}",
                                    style: Get.textTheme.titleSmall,
                                  ),
                                ),
                              ),
                            ),
                            //todo
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                width: double.infinity,
                                height: 200.h,
                                decoration: BoxDecoration(
                                  color: Get.theme.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: doc['userJourney'] != null
                                    ? ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          for (var step in doc['userjourney']
                                              .cast<String, String>()
                                              .entries
                                              .toList())
                                            Image.network(step),
                                          const Icon(EvaIcons.plusCircle)
                                        ],
                                      )
                                    : GestureDetector(
                                        onTap: () => controller.openDialog(
                                          controller,
                                          () => controller.openCamera(
                                              controller,
                                              ischangeUserImage: true),
                                          () => controller.openGallery(
                                              controller,
                                              ischangeUserImage: true),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Coming Soon",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(letterSpacing: 0),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => firebaseAuth.signOut(),
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25.w),
                                  width: double.infinity,
                                  height: 200.h,
                                  decoration: BoxDecoration(
                                    color: Get.theme.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        SettingsConstants.LOGOUT,
                                        style: Get.textTheme.titleSmall,
                                      ),
                                      Icon(
                                        EvaIcons.logOutOutline,
                                        color: Get.theme.iconButtonTheme.style!
                                            .iconColor!
                                            .resolve({}),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text(PublicConstants.NODATA));
                  } else {
                    return const Center(child: QFProgressIndicator());
                  }
                });
          }),
    );
  }
}
