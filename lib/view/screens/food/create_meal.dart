import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quantum_muscle/controller/food/create_meal_controller.dart';

import '../../../constants/text_constants.dart';
import '../../widgets/private/workouts/workouts_widgets.dart';
import '../../widgets/public/button_widget.dart';
import '../../widgets/public/text_field_widget.dart';

class CreateMealPage extends StatefulWidget {
  const CreateMealPage({super.key});

  @override
  State<CreateMealPage> createState() => _CreateMealPageState();
}

class _CreateMealPageState extends State<CreateMealPage> {
  late TextEditingController nameController;

  late TextEditingController ingredientsController;

  late File imagePicked;

  bool isImagePicked = false;

  final controller = CreateMealController();

  void openGallery() async {
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

  void openCamera() async {
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
              MealsConstants.CHOOSEOPTION,
              style: Get.textTheme.headlineMedium,
            ),
            SizedBox(
              height: 30.h,
            ),
            QFSuperButton(
              text: MealsConstants.OPENCAMERA,
              onTap: () => openCamera(),
              icon: EvaIcons.battery,
            ),
            SizedBox(height: 25.h),
            QFSuperButton(
              text: MealsConstants.OPENGALLERY,
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
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ingredientsController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    ingredientsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    final index = arguments[0];
    final mealName = arguments[1];

    return Scaffold(
      extendBody: true,
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
                hintText: MealsConstants.MEALNAME,
                hasNext: true,
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                height: 700.h,
                child: QFTextField(
                  controller: ingredientsController,
                  hintText: MealsConstants.MEALINGREDIENTS,
                  isExpanded: true,
                ),
              ),
              SizedBox(
                height: 250.h,
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
                    CreateMealController()
                        .createMeal(mealName, index, nameController.text,
                            ingredientsController.text, imagePicked).then((_) {
                              nameController.clear();
                              ingredientsController.clear();
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
              SizedBox(
                height: 100.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
