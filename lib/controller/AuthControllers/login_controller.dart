import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quantum_muscle/constants/routes_constants.dart';
import 'package:quantum_muscle/model/auth/login_provider_model.dart';

class LogInController extends GetxController {
  // final TextEditingController emailAddressController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  final firebaseAuthInstants = FirebaseAuth.instance;

  

  void logUserIn(String email, String password) {
    firebaseAuthInstants
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .whenComplete(() => Get.toNamed(RoutesConstants.homePage));
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  List<LoginProvidersModel> loginProviders = <LoginProvidersModel>[
    LoginProvidersModel(
      providerName: 'Google',
      providerIcon: EvaIcons.google,
   
    ),
    // LoginProvidersModel(
    //   providerName: 'Facebook',
    //   providerIcon: EvaIcons.facebook,
    // )
  ];
}
