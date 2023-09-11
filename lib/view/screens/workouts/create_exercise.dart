import 'dart:io';

import '../../../library.dart';

class CreateExercisePage extends StatefulWidget {
  const CreateExercisePage({super.key});

  @override
  State<CreateExercisePage> createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {
  final nameController = TextEditingController();
  final targetController = TextEditingController();
  late File imagePicked;
  bool isImagePicked = false;

  Future<void> openGallery() async {
    ImagePicker picker = ImagePicker();
    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 250,
        maxHeight: 250,
        imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        imagePicked = File(pickedFile.path);
        isImagePicked = true;
      });
      Get.back();
    }
  }

  Future<void> openCamera() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      ImagePicker picker = ImagePicker();
      var pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          maxWidth: 250,
          maxHeight: 250,
          imageQuality: 100);
      if (pickedFile != null) {
        Get.back();
        setState(() {
          imagePicked = File(pickedFile.path);
          isImagePicked = true;
        });
      }
    } else {
      await Permission.camera.request();
      openCamera();
    }
  }

  void openDialog() {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              ExercisesConstants.CHOOSEOPTION,
              style: Get.textTheme.headlineMedium,
            ),
            SizedBox(
              height: 30.h,
            ),
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
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget showImage() {
    if (isImagePicked) {
      return GestureDetector(
        child: Image.file(imagePicked),
        onTap: () => openDialog(),
      );
    } else {
      return IconButton(
        onPressed: () => openDialog(),
        icon: const Icon(
          Icons.image,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    final String index = arguments[0];
    final String workoutName = arguments[1];

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 65.w,
                  right: 65.w,
                ),
                child: Container(
                  height: 400.h,
                  width: 400.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border:
                          Border.all(width: 2, color: Get.theme.primaryColor),
                      color: Colors.transparent),
                  child: showImage(),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              QFTextField(
                  controller: nameController,
                  hintText: ExercisesConstants.NAME),
              SizedBox(
                height: 40.h,
              ),
              QFTextField(
                controller: targetController,
                hintText: ExercisesConstants.TARGET,
                hasNext: false,
              ),
              SizedBox(
                height: 750.h,
              ),
              QFButton(
                onTap: () {
                  if (isImagePicked) {
                    Get.rawSnackbar(
                      snackStyle: SnackStyle.GROUNDED,
                      title: PublicConstants.LOADING,
                      message: PublicConstants.PLEASEWAIT,
                      backgroundColor: Get.theme.primaryColor.withOpacity(.3),
                      showProgressIndicator: true,
                      duration: 1.days,
                    );
                    CreateExerciseController()
                        .createExercise(workoutName, index, nameController.text,
                            targetController.text, imagePicked)
                        .then((_) {
                          nameController.clear();
                          targetController.clear();
                        })
                        .then((_) => Get.closeAllSnackbars())
                        .then((_) => Get.rawSnackbar(
                              snackStyle: SnackStyle.GROUNDED,
                              title: PublicConstants.SUCCESS,
                              message: PublicConstants.GOBACK,
                              backgroundColor:
                                  Get.theme.primaryColor.withOpacity(.3),
                              duration: 3.seconds,
                            ));
                  } else {
                    Get.rawSnackbar(
                      snackStyle: SnackStyle.GROUNDED,
                      title: PublicConstants.ERROR,
                      message: PublicConstants.CHOOSEIMAGE,
                      backgroundColor: Get.theme.primaryColor.withOpacity(.3),
                    );
                  }
                },
                text: PublicConstants.CREATE,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
