import 'dart:io';

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
  late File imagePicked;

  final heightTextController = TextEditingController();
  final weightTextController = TextEditingController();
  final bioTextController = TextEditingController();
  int heightAndWeightIndex = 0;
  Future<void> openGallery(SettingsController controller) async {
    ImagePicker picker = ImagePicker();
    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        imagePicked = File(pickedFile.path);
      });
      Get.back();
      controller.changeImage(imagePicked);
    }
  }

  Future<void> openCamera(SettingsController controller) async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      ImagePicker picker = ImagePicker();
      var pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          maxWidth: 512,
          maxHeight: 512,
          imageQuality: 100);
      if (pickedFile != null) {
        setState(() {
          imagePicked = File(pickedFile.path);
        });
        Get.back();

        controller.changeImage(imagePicked);
      }
    } else {
      await Permission.camera.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      autoRemove: false,
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: FutureBuilder(
              future: firebaseFirestore.collection('users').doc(uid).get(),
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
                                        onTap: () => openDialog(
                                          controller,
                                          () => openCamera(controller),
                                          () => openGallery(controller),
                                        ),
                                        child: Container(
                                          width: 300.w,
                                          height: 300.h,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
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
                                        onTap: () =>
                                            changeHeightAndWeightDialog(
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
                                        onTap: () => openDialog(
                                          controller,
                                          () => openCamera(controller),
                                          () => openGallery(controller),
                                        ),
                                        child: Container(
                                          width: 300.w,
                                          height: 300.h,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color:
                                                      Get.theme.primaryColor)),
                                          child: const Icon(EvaIcons.person),
                                        ),
                                      ),
                                      SizedBox(width: 30.w),
                                      GestureDetector(
                                        onTap: () =>
                                            changeHeightAndWeightDialog(
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
                              onTap: () => changeBioDialog(controller),
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
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () => firebaseAuth.signOut(),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
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
              }),
        );
      },
    );
  }

  Future<void> changeBioDialog(SettingsController controller) {
    return Get.dialog(
      barrierDismissible: true,
      Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 500.h,
              child: QFTextField(
                  maxLength: 100,
                  hasNext: false,
                  isExpanded: true,
                  controller: bioTextController,
                  hintText: "Bio ( 100 characters max! )"),
            ),
            SizedBox(height: 25.h),
            QFSuperButton(
              text: PublicConstants.SAVE,
              onTap: () => controller.changeBio(bioTextController.text),
              icon: EvaIcons.folder,
            ),
          ],
        ),
      ),
    );
  }
}

void openDialog(SettingsController controller,
    Future<void> Function() openCamera, Future<void> Function() openGallery) {
  Get.dialog(
    barrierDismissible: true,
    Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QFSuperButton(
            text: PublicConstants.OPENCAMERA,
            onTap: () => openCamera(),
            icon: EvaIcons.battery,
          ),
          SizedBox(height: 25.h),
          QFSuperButton(
            text: PublicConstants.OPENGALLERY,
            onTap: () => openGallery(),
            icon: EvaIcons.folder,
          ),
        ],
      ),
    ),
  );
}

void changeHeightAndWeightDialog(
  SettingsController controller,
  TextEditingController heightTextController,
  TextEditingController weightTextController,
  int heightAndWeightIndex,
) {
  Get.dialog(
    barrierDismissible: true,
    Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QFTextField(
              maxLength: 5,
              hasNext: true,
              controller: heightTextController,
              keyboardType: TextInputType.number,
              hintText: "Height in cm or in"),
          QFTextField(
              maxLength: 5,
              hasNext: false,
              keyboardType: TextInputType.number,
              controller: weightTextController,
              hintText: "weight in kg or lb"),
          SizedBox(height: 25.h),
          QFSuperButton(
            text: PublicConstants.SAVE,
            onTap: () => controller.changeHeightAndWeight(
                heightTextController.text,
                weightTextController.text,
                heightAndWeightIndex.toString()),
            icon: EvaIcons.folder,
          ),
        ],
      ),
    ),
  );
}
