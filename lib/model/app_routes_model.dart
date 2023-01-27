import 'package:get/get.dart';
import 'package:quantum_muscle/constants/routes_constants.dart';
import 'package:quantum_muscle/view/screens/auth/forget_password.dart';
import 'package:quantum_muscle/view/screens/auth/login.dart';
import 'package:quantum_muscle/view/screens/auth/signup.dart';
import 'package:quantum_muscle/view/screens/main/main_page.dart';
import 'package:quantum_muscle/view/screens/workouts/exercises.dart';

final List<GetPage> appRoutes = <GetPage>[
  GetPage(
    name: RoutesConstants.loginPage,
    page: () => LoginPage(),
    transition: Transition.size,
    transitionDuration: 300.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.signupPage,
    page: () => SignupPage(),
    transition: Transition.size,
    transitionDuration: 300.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.mainPage,
    page: () => MainPage(),
  ),
  GetPage(
    name: RoutesConstants.forgetPasswordPage,
    page: () => ForgetPasswordPage(),
    transition: Transition.circularReveal,
    transitionDuration: 300.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.exercisesPage,
    page: () => const ExercisesPage(),
    transition: Transition.fadeIn,
    transitionDuration: 200.milliseconds,
  ),
];
