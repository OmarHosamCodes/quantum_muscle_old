import '../../library.dart';

class SignupController extends GetxController {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  UserModel userModel = UserModel();

  late User? user = firebaseAuth.currentUser;

  Future signUserUp(
    String email,
    String password,
    String userName,
    GlobalKey<FormState> formKey,
  ) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((_) {
        if (firebaseAuth.currentUser != null) {
          afterSignUp(userName);
          Get.snackbar(PublicConstants.SUCCESS, "Register Is Successfully");
          Get.toNamed(RoutesConstants.MASTERPAGE);
        } else {
          return;
        }
      });
    } on FirebaseAuthException catch (e) {
      String? errorMessage;
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          errorMessage = 'Invalid email address';
          break;
        case 'ERROR_USER_NOT_FOUND':
          errorMessage = 'User not found';
          break;
        // ...
        default:
          errorMessage = 'An error occurred, please try again later';
          break;
      }
      Get.rawSnackbar(
        title: PublicConstants.ERROR,
        message: errorMessage,
      );
    }
  }

  afterSignUp(String userName) async {
    if (user != null) {
      userModel.email = user!.email;
      userModel.uid = user!.uid;
      userModel.userName = userName;
      userModel.userBio = null;
      userModel.userImage = null;
      userModel.userWeight = null;
      userModel.userHeight = null;
      await firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .set(userModel.toMap());
    }
  }
}
