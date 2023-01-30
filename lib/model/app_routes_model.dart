import 'package:get/get.dart';

import 'package:quantum_muscle/view/screens/auth/forget_password.dart';
import 'package:quantum_muscle/view/screens/auth/login.dart';
import 'package:quantum_muscle/view/screens/auth/signup.dart';
import 'package:quantum_muscle/view/screens/main/main_page.dart';
import 'package:quantum_muscle/view/screens/workouts/exercises.dart';

import '../constants/text_constants.dart';

final List<GetPage> appRoutes = <GetPage>[
  GetPage(
    name: RoutesConstants.LOGINPAGE,
    page: () => LoginPage(),
    transition: Transition.size,
    transitionDuration: 300.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.SIGNUPPAGE,
    page: () => SignupPage(),
    transition: Transition.size,
    transitionDuration: 300.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.MAINPAGE,
    page: () => MainPage(),
  ),
  GetPage(
    name: RoutesConstants.FORGETPASSWORDPAGE,
    page: () => ForgetPasswordPage(),
    transition: Transition.circularReveal,
    transitionDuration: 300.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.EXERCISESPAGE,
    page: () => const ExercisesPage(),
    transition: Transition.fadeIn,
    transitionDuration: 200.milliseconds,
  ),
];
