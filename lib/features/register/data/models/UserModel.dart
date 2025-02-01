class UserModel {
  final String? uid;
  final String? username;
  final String? bio;
  final String? phone;
  final String? gender;
  final String? website;
  final String? email;
  final String? profileUrl;
  final List<String>? followers;
  final List<String>? following;
  final num? totalFollowers;
  final num? totalFollowing;
  final num? totalPosts;
  final bool? isOnline;
  final String? token;

  UserModel({
    this.uid,
    this.username,
    this.bio,
    this.phone,
    this.gender,
    this.website,
    this.email,
    this.profileUrl,
    this.followers,
    this.following,
    this.totalFollowers,
    this.totalFollowing,
    this.totalPosts,
    this.isOnline,
    this.token,
  });

  /// Convert UserModel to Firestore JSON
  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "username": username,
      "bio": bio ?? "",
      "phone": phone ?? "",
      "gender": gender ?? "",
      "website": website ?? "",
      "email": email,
      "profileUrl": profileUrl ?? "",
      "followers": followers ?? [],
      "following": following ?? [],
      "totalFollowers": totalFollowers ?? 0,
      "totalFollowing": totalFollowing ?? 0,
      "totalPosts": totalPosts ?? 0,
      "isOnline": isOnline ?? false,
      "token": token ?? "",
    };
  }

  /// Convert Firestore JSON to `UserModel`
  factory UserModel.fromFirestore(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      username: json["username"],
      bio: json["bio"],
      phone: json["phone"],
      gender: json["gender"],
      website: json["website"],
      email: json["email"],
      profileUrl: json["profileUrl"],
      followers: List<String>.from(json["followers"] ?? []),
      following: List<String>.from(json["following"] ?? []),
      totalFollowers: json["totalFollowers"] ?? 0,
      totalFollowing: json["totalFollowing"] ?? 0,
      totalPosts: json["totalPosts"] ?? 0,
      isOnline: json["isOnline"] ?? false,
      token: json["token"],
    );
  }
}
