class UserModel {
  String? uid;
  String? email;
  String? userName;
  String? userImage;
  String? userBio;
  Map<String, String>? userWeight;
  Map<String, String>? userHeight;

  UserModel({
    this.uid,
    this.email,
    this.userName,
    this.userImage,
    this.userBio,
    this.userWeight,
    this.userHeight,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      userImage: map['userImage'],
      userBio: map['userBio'],
      userWeight: map['userWeight'],
      userHeight: map['userHeight'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
      'userImage': userImage,
      'userBio': userBio,
      'userWeight': userWeight,
      'userHeight': userHeight
    };
  }
}
