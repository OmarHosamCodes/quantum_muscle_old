import 'dart:io';

import '../../library.dart';

class SettingsController extends GetxController {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  UserModel userModel = UserModel();
  late File imagePicked;
  late User? user = firebaseAuth.currentUser;
  final ImagePicker imagePicker = ImagePicker();

  Future<void> changeImage(File imageFile) async {
    if (user != null) {
      try {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child(user!.uid)
            .child("UserInfo")
            .child("${user!.uid}UserImage");
        UploadTask uploadeTask = storageReference.putFile(imageFile);
        Get.back();
        await uploadeTask.whenComplete(
          () async =>
              await firebaseFirestore.collection("users").doc(user!.uid).update(
            {"userImage": await storageReference.getDownloadURL()},
          ),
        );
        update();
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  //TODO

  // Future<void> addJourneyStep(String journeyStep, String index) async {
  //   if (user != null) {
  //     try {
  //       await firebaseFirestore.collection("users").doc(user!.uid).set(
  //         {
  //           "userJourney": {index: journeyStep},
  //         },
  //         SetOptions(
  //           merge: true,
  //         ),
  //       );
  //       Get.back();
  //       update();
  //     } catch (e) {
  //       Get.rawSnackbar(
  //         title: PublicConstants.ERROR,
  //         message: e.toString(),
  //       );
  //     }
  //   }
  // }

  Future<void> changeBio(String newBio) async {
    if (user != null) {
      try {
        await firebaseFirestore
            .collection("users")
            .doc(user!.uid)
            .update({"userBio": newBio});
        Get.back();
        update();
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> changeHeightAndWeight(
      String newHeight, String newWeight, String index) async {
    if (user != null) {
      try {
        await firebaseFirestore.collection("users").doc(user!.uid).set(
          {
            "userHeight": {index: newHeight},
            "userWeight": {index: newWeight},
          },
          SetOptions(
            merge: true,
          ),
        );
        Get.back();
        update();
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> openGallery(SettingsController controller,
      {bool ischangeUserImage = false}) async {
    var pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100);
    if (pickedFile != null) {
      imagePicked = File(pickedFile.path);
      update();
      Get.dialog(
        Dialog(
          backgroundColor: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.file(imagePicked),
              QFButton(
                onTap: () {
                  ischangeUserImage
                      ? controller.changeImage(imagePicked)
                      : null;
                  pickedFile = null;
                  Get.back();
                  update();
                },
                text: PublicConstants.SAVE,
              ),
            ],
          ),
        ),
        barrierColor: Colors.black87,
      );
    }
  }

  Future<void> openCamera(SettingsController controller,
      {bool ischangeUserImage = false}) async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      var pickedFile = await imagePicker.pickImage(
          source: ImageSource.camera,
          maxWidth: 512,
          maxHeight: 512,
          imageQuality: 100);
      if (pickedFile != null) {
        imagePicked = File(pickedFile.path);
        update();
        Get.dialog(
          Dialog(
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0.867),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.file(imagePicked),
                QFButton(
                  onTap: () {
                    ischangeUserImage
                        ? controller.changeImage(imagePicked)
                        : null;
                    pickedFile = null;
                    Get.back();
                    update();
                  },
                  text: PublicConstants.SAVE,
                ),
              ],
            ),
          ),
          barrierColor: const Color.fromRGBO(0, 0, 0, 0.867),
        );
      }
    } else {
      await Permission.camera.request();
    }
  }

  Future<void> changeBioDialog(
      SettingsController controller, TextEditingController bioTextController) {
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
}
