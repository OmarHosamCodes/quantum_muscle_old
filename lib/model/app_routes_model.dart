import 'package:get/get.dart';
import 'package:quantum_muscle/main.dart';
import 'package:quantum_muscle/view/screens/auth/forget_password.dart';
import 'package:quantum_muscle/view/screens/auth/login.dart';
import 'package:quantum_muscle/view/screens/auth/signup.dart';
import 'package:quantum_muscle/view/screens/food/create_meal.dart';
import 'package:quantum_muscle/view/screens/food/meals.dart';
import 'package:quantum_muscle/view/screens/workouts/create_exercise.dart';
import 'package:quantum_muscle/view/screens/workouts/exercises.dart';
import 'package:quantum_muscle/view/screens/workouts/workouts.dart';
import '../constants/text_constants.dart';

final List<GetPage> appRoutes = <GetPage>[
  GetPage(
    name: RoutesConstants.LOGINPAGE,
    page: () => const LoginPage(),
    transition: Transition.fadeIn,
    transitionDuration: 200.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.SIGNUPPAGE,
    page: () => const SignupPage(),
    transition: Transition.fadeIn,
    transitionDuration: 200.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.MASTERPAGE,
    page: () => const MasterPage(),
    transition: Transition.fadeIn,
    transitionDuration: 200.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.FORGETPASSWORDPAGE,
    page: () => const ForgetPasswordPage(),
    transition: Transition.fadeIn,
    transitionDuration: 200.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.EXERCISESPAGE,
    page: () => const ExercisesPage(),
    transition: Transition.fadeIn,
    transitionDuration: 200.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.CREATEEXERCISEPAGE,
    page: () => const CreateExercisePage(),
    transition: Transition.fadeIn,
    transitionDuration: 200.milliseconds,
  ),
  GetPage(
      name: RoutesConstants.WORKOUTSPAGE,
      page: () => const WorkoutsPage(),
      transition: Transition.fadeIn,
      transitionDuration: 200.milliseconds),
  GetPage(
      name: RoutesConstants.MEALSPAGE,
      page: () => const MealsPage(),
      transition: Transition.fadeIn,
      transitionDuration: 200.milliseconds),
  GetPage(
      name: RoutesConstants.CREATEMEALPAGE,
      page: () => const CreateMealPage(),
      transition: Transition.fadeIn,
      transitionDuration: 200.milliseconds),
];
