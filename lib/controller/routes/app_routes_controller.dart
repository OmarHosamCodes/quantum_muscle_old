import '../../library.dart';

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
    page: () => const MainPage(),
    transition: Transition.fadeIn,
    transitionDuration: 200.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.FORGETPASSWORDPAGE,
    page: () => const ForgetPasswordPage(),
    transition: Transition.rightToLeftWithFade,
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
    transitionDuration: 200.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.MEALSPAGE,
    page: () => const MealsPage(),
    transition: Transition.fadeIn,
    transitionDuration: 200.milliseconds,
  ),
  GetPage(
    name: RoutesConstants.CREATEMEALPAGE,
    page: () => const CreateMealPage(),
    transition: Transition.fadeIn,
    transitionDuration: 200.milliseconds,
  ),
];
