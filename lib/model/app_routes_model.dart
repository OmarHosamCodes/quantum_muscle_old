import 'package:get/get.dart';
import 'package:quantum_muscle/constants/routes_constants.dart';
import 'package:quantum_muscle/view/screens/auth/login.dart';
import 'package:quantum_muscle/view/screens/auth/signup.dart';
import 'package:quantum_muscle/view/screens/home/home.dart';

final List<GetPage> appRoutes = <GetPage>[
  GetPage(
    name: RoutesConstants.loginPage,
    page: () =>    LoginPage(),
    transition: Transition.circularReveal,
    transitionDuration: const Duration(
      milliseconds: 300,
    ),
  ),
  GetPage(
    name: RoutesConstants.signupPage,
    page: () =>  SignupPage(),
    transition: Transition.circularReveal,
    transitionDuration: const Duration(
      milliseconds: 500,
    ),
  ),
  GetPage(
    name: RoutesConstants.homePage,
    page: () => HomePage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(
      milliseconds: 500,
    ),
  ),
];
