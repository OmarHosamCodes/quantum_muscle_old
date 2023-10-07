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
  bool isImagePicked = false;
  final heightTextController = TextEditingController();
  final weighTextController = TextEditingController();
  final bioTextController = TextEditingController();
  int heightAndWeightIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      autoRemove: false,
      builder: (controller) {
        Future<void> openGallery() async {
          ImagePicker picker = ImagePicker();
          var pickedFile = await picker.pickImage(
              source: ImageSource.gallery,
              maxWidth: 512,
              maxHeight: 512,
              imageQuality: 100);
          if (pickedFile != null) {
            setState(() {
              imagePicked = File(pickedFile.path);
              isImagePicked = true;
            });
            if (isImagePicked) {
              Get.rawSnackbar(
                snackStyle: SnackStyle.GROUNDED,
                title: PublicConstants.LOADING,
                message: PublicConstants.PLEASEWAIT,
                backgroundColor: Get.theme.primaryColor.withOpacity(.3),
                showProgressIndicator: true,
                duration: 1.days,
              );
              controller
                  .changeImage(imagePicked)
                  .then((_) => Get.closeAllSnackbars());
            }
            Get.back();
          }
        }

        Future<void> openCamera() async {
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
                isImagePicked = true;
              });
              if (isImagePicked) {
                Get.rawSnackbar(
                  snackStyle: SnackStyle.GROUNDED,
                  title: PublicConstants.LOADING,
                  message: PublicConstants.PLEASEWAIT,
                  backgroundColor: Get.theme.primaryColor.withOpacity(.3),
                  showProgressIndicator: true,
                  duration: 1.days,
                );
                controller
                    .changeImage(imagePicked)
                    .then((_) => Get.closeAllSnackbars());
              }
              Get.back();
            }
          } else {
            await Permission.camera.request();
            openCamera();
          }
        }

        void openDialog() {
          Get.dialog(
            barrierDismissible: true,
            Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(height: 400.h),
                ],
              ),
            ),
          );
        }

        void changeHeightAndWeightDialog() {
          Get.dialog(
            barrierDismissible: true,
            Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QFTextField(
                      maxLength: 5,
                      hasNext: true,
                      controller: heightTextController,
                      hintText: "Height in cm or in"),
                  SizedBox(height: 25.h),
                  QFTextField(
                      maxLength: 5,
                      hasNext: false,
                      controller: weighTextController,
                      hintText: "weight in kg or lb"),
                  SizedBox(height: 25.h),
                  QFSuperButton(
                    text: PublicConstants.SAVE,
                    onTap: () => controller.changeHeightAndWeight(
                        heightTextController.text,
                        weighTextController.text,
                        heightAndWeightIndex.toString()),
                    icon: EvaIcons.folder,
                  ),
                  SizedBox(height: 400.h),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          extendBody: true,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 30,
              ),
              child: FutureBuilder(
                  future: firebaseFirestore.collection('users').doc(uid).get(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic>? doc = snapshot.data!.data();

                      // List heightMap = doc!['userHeight'];
                      // String height = heightMap.last;

                      // heightAndWeightIndex = heightMap.length;
                      // List weightMap = doc['userWeight'];

                      // String weight = weightMap.last;
                      Map<String, String> heightMap =
                          doc!['userHeight'].cast<String, String>();
                      String height = heightMap.values.lastOrNull!;

                      heightAndWeightIndex = heightMap.length;
                      Map<String, String> weightMap =
                          doc['userWeight'].cast<String, String>();

                      String weight = weightMap.values.lastOrNull!;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: doc['userImage'] != null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => openDialog(),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Get.theme.primaryColor,
                                          child: Image(
                                            width: double.maxFinite,
                                            image: CachedNetworkImageProvider(
                                              doc['userImage'],
                                            ),
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return SizedBox(
                                                height: 500.h,
                                                width: 500.w,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        Get.theme.primaryColor,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    SizedBox(
                                              height: 500.h,
                                              width: 500.w,
                                              child: Center(
                                                child: Text(
                                                  "Error while uploading",
                                                  style:
                                                      Get.textTheme.titleMedium,
                                                ),
                                              ),
                                            ),
                                            filterQuality: FilterQuality.high,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            changeHeightAndWeightDialog(),
                                        child: Text(
                                          "\n${doc['userName'].toString()}\nHeight: $height\nWeight: $weight\n",
                                          style: Get.textTheme.titleSmall,
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => openDialog(),
                                        child: CircleAvatar(
                                          radius: 100.r,
                                          child: const Icon(EvaIcons.person),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            changeHeightAndWeightDialog(),
                                        child: Text(
                                          "\n${doc['userName'].toString()}\nHeight: $height\nWeight: $weight\n",
                                          style: Get.textTheme.titleSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          Flexible(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () => Get.dialog(
                                barrierDismissible: true,
                                Dialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 500.h,
                                        child: QFTextField(
                                            maxLength: 100,
                                            hasNext: false,
                                            isExpanded: true,
                                            controller: bioTextController,
                                            hintText:
                                                "Bio ( 100 characters max! )"),
                                      ),
                                      SizedBox(height: 25.h),
                                      QFSuperButton(
                                        text: PublicConstants.SAVE,
                                        onTap: () => controller
                                            .changeBio(bioTextController.text),
                                        icon: EvaIcons.folder,
                                      ),
                                      SizedBox(height: 400.h),
                                    ],
                                  ),
                                ),
                              ),
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
                      );
                    } else {
                      return const Center(child: Text("No Data"));
                    }
                  }),
            ),
          ),
        );
      },
    );
  }
}
