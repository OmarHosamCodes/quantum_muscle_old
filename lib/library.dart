library library;

//* Screens

export 'view/screens/main/main_page.dart';
export 'view/screens/auth/login.dart';
export 'view/screens/auth/forget_password.dart';
export 'view/screens/auth/signup.dart';
export 'view/screens/food/create_meal.dart';
export 'view/screens/food/meals.dart';
export 'view/screens/workouts/create_exercise.dart';
export 'view/screens/workouts/exercises.dart';
export 'view/screens/workouts/workouts.dart';
export 'view/screens/food/meal_groups.dart';
export 'view/screens/settings/settings.dart';
export 'main.dart';
export 'firebase_options.dart';

//* Widgets

export 'view/widgets/public/button_widget.dart';
export 'view/widgets/public/progress_indicator_widget.dart';
export 'view/widgets/public/text_field_widget.dart';
export 'view/widgets/public/rowed_text_widget.dart';
export 'view/widgets/private/workouts/workouts_widgets.dart';

//* Controllers

export 'controller/theme/theme_controller.dart';
export 'controller/workouts/workouts_controller.dart';
export 'controller/workouts/create_exercise_controller.dart';
export 'controller/main/main_page_controller.dart';
export 'controller/food/meal_group_controller.dart';
export 'controller/food/create_meal_controller.dart';
export 'controller/auth/forget_password_controller.dart';
export 'controller/auth/login_controller.dart';
export 'controller/auth/signup_controller.dart';
export 'controller/ui/resposive_controller.dart';
export 'controller/settings/settings_controller.dart';

//* Models

export 'model/app_routes_model.dart';
export 'model/auth/user_model.dart';
export 'model/food/meal_model.dart';
export 'model/food/meal_group_model.dart';
export 'model/workouts/exercise_model.dart';
export 'model/workouts/workout_model.dart';

//* Constants

export 'constants/text_constants.dart';

//* Packages

export 'package:firebase_auth/firebase_auth.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter_native_splash/flutter_native_splash.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:get/get.dart';
export 'package:get_storage/get_storage.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:eva_icons_flutter/eva_icons_flutter.dart';
export 'package:flutter_hooks/flutter_hooks.dart';
export 'package:image_picker/image_picker.dart';
export 'package:permission_handler/permission_handler.dart';
export 'package:google_nav_bar/google_nav_bar.dart';
export 'package:email_validator/email_validator.dart';
export 'package:firebase_storage/firebase_storage.dart';
export 'package:flutter/foundation.dart';
export 'package:cached_network_image/cached_network_image.dart';