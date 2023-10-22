import '/library.dart';

class IntentController extends GetxController {
  StreamSubscription<dynamic>? dataStreamSubscription;
  // static const String sharedTextKey = "sharedTextKey";
  // late RxString sharedText = ''.obs;
  // late RxString sharedMediaPath = ''.obs;
  // Rx<SharedMediaFile>? sharedFile;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  ExerciseModel exerciseModel = ExerciseModel();
  late User? user = firebaseAuth.currentUser;

  intentHandler() {
    dataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String? text) async {
      if (text != null) {
        // sharedText.value = text;
        Get.toNamed(RoutesConstants.INTENTPAGE, arguments: [text]);
      }
    });

    ReceiveSharingIntent.getInitialText().then((String? text) async {
      if (text != null) {
        // sharedText.value = text;
        Get.toNamed(RoutesConstants.INTENTPAGE, arguments: [text]);
      }
    });
    //todo
    // dataStreamSubscription = ReceiveSharingIntent.getMediaStream()
    //     .listen((List<SharedMediaFile>? media) async {
    //   if (media != null) {
    //     for (var i = 0; i < media.length; i++) {
    //       sharedMediaPath.value = media[0].path;
    //     }
    //   }
    // });
    // ReceiveSharingIntent.getInitialMedia()
    //     .then((List<SharedMediaFile>? media) async {
    //   if (media != null) {
    //     for (var i = 0; i < media.length; i++) {
    //       sharedMediaPath.value = media[0].path;
    //     }
    //   }
    // });
  }

  Future<void> addToWorkout(
      String workoutName, String index, String sharedText) async {
    if (user != null) {
      try {
        final textToJson = jsonDecode(sharedText);
        final exerciseAsMap = ExerciseModel.fromMap(textToJson);
        exerciseModel.exerciseName = exerciseAsMap.exerciseName;
        exerciseModel.exerciseImage = exerciseAsMap.exerciseImage;
        exerciseModel.exerciseTarget = exerciseAsMap.exerciseTarget;
        exerciseModel.sets = exerciseAsMap.sets;
        await firebaseFirestore
            .collection('users')
            .doc(user!.uid)
            .collection('workouts')
            .doc(workoutName)
            .collection(index)
            .doc(exerciseModel.exerciseName)
            .set(exerciseModel.toMap())
            .then((value) => Get.offAndToNamed(RoutesConstants.MASTERPAGE));
      } catch (e) {
        Get.rawSnackbar(
          title: PublicConstants.ERROR,
          message: e.toString(),
        );
      }
    }
  }
}
