import 'dart:io';

import '../../library.dart';

class SettingsController extends GetxController {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  UserModel userModel = UserModel();

  late User? user = firebaseAuth.currentUser;

  Future<void> changeImage(File imageFile) async {
    if (user != null) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child(user!.uid)
          .child("UserInfo")
          .child("${user!.uid}UserImage");
      UploadTask uploadeTask = storageReference.putFile(imageFile);
      try {
        await uploadeTask.whenComplete(
          () async =>
              await firebaseFirestore.collection("users").doc(user!.uid).update(
            {"userImage": await storageReference.getDownloadURL()},
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
}
