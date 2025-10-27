class UserProfileModel {
  final String? id;
  final String? email;
  final int? totalCarrots;
  final String? fullName;
  final DateTime? lastLoginAt;
  final String? phone;
  final String? address;
  final bool? isHePlayedFirstTime;
  final String? currentGametag;
  final String? role;
  final String? profileStatus;
  final bool? isEmailVerified;
  final DateTime? lastPasswordChange;
  final bool? isHeBroughtFirstTime;
  final bool? isResetPassword;
  final int? failedLoginAttempts;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserProfileModel({
    this.id,
    this.email,
    this.totalCarrots,
    this.fullName,
    this.lastLoginAt,
    this.phone,
    this.address,
    this.isHePlayedFirstTime,
    this.currentGametag,
    this.role,
    this.profileStatus,
    this.isEmailVerified,
    this.lastPasswordChange,
    this.isHeBroughtFirstTime,
    this.isResetPassword,
    this.failedLoginAttempts,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    id: json["_id"],
    email: json["email"],
    totalCarrots: json["totalCarrots"],
    fullName: json["fullName"],
    lastLoginAt: json["lastLoginAt"] == null ? null : DateTime.parse(json["lastLoginAt"]),
    phone: json["phone"],
    address: json["address"],
    isHePlayedFirstTime: json["isHePlayedFirstTime"],
    currentGametag: json["CurrentGametag"],
    role: json["role"],
    profileStatus: json["profileStatus"],
    isEmailVerified: json["isEmailVerified"],
    lastPasswordChange: json["lastPasswordChange"] == null ? null : DateTime.parse(json["lastPasswordChange"]),
    isHeBroughtFirstTime: json["isHeBroughtFirstTime"],
    isResetPassword: json["isResetPassword"],
    failedLoginAttempts: json["failedLoginAttempts"],
    profileImage: json["profileImage"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "totalCarrots": totalCarrots,
    "fullName": fullName,
    "lastLoginAt": lastLoginAt?.toIso8601String(),
    "phone": phone,
    "address": address,
    "isHePlayedFirstTime": isHePlayedFirstTime,
    "CurrentGametag": currentGametag,
    "role": role,
    "profileStatus": profileStatus,
    "isEmailVerified": isEmailVerified,
    "lastPasswordChange": lastPasswordChange?.toIso8601String(),
    "isHeBroughtFirstTime": isHeBroughtFirstTime,
    "isResetPassword": isResetPassword,
    "failedLoginAttempts": failedLoginAttempts,
    "profileImage": profileImage,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
