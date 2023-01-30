import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quantum_muscle/view/widgets/private/workouts/workouts_widgets.dart';
import 'package:quantum_muscle/view/widgets/public/button_widget.dart';
import 'package:quantum_muscle/view/widgets/public/text_field_widget.dart';

import '../../../constants/text_constants.dart';
import '../../../controller/workouts/create_exercise_controller.dart';

class CreateWorkoutPage extends StatefulWidget {
  const CreateWorkoutPage({super.key});

  @override
  State<CreateWorkoutPage> createState() => _CreateWorkoutPageState();
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> {
  final nameController = TextEditingController();

  final targetController = TextEditingController();

  late File imagePicked;

  bool imageselected = false;

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
        imageselected = true;
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
          imageselected = true;
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
              text: ExercisesConstants.OPENCAMERA,
              onTap: () => openCamera(),
              icon: EvaIcons.battery,
            ),
            SizedBox(height: 25.h),
            QFSuperButton(
              text: ExercisesConstants.OPENGALLERY,
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
    if (imageselected) {
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: EdgeInsets.only(
          top: 100.h,
          // left: 50.w,
          // right: 50.w,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 50.w,
                  right: 50.w,
                ),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(width: 1, color: Get.theme.primaryColor),
                      color: Colors.transparent),
                  child: showImage(),
                ),
              ),
              SizedBox(
                height: 150.h,
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
                height: 300.h,
              ),
              QFButton(
                onTap: () => CreateExerciseController()
                    .createExercise(workoutName, index, nameController.text,
                        targetController.text, imagePicked)
                    .then((value) => Get.back()),
                text: ExercisesConstants.CREATE,
              ),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
