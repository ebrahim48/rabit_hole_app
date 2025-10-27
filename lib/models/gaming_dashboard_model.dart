class GamingDashBoardModel {
  final GameDashboard? gameDashboard;
  final int? achievements;
  final int? dashboardAchievements;

  GamingDashBoardModel({
    this.gameDashboard,
    this.achievements,
    this.dashboardAchievements,
  });

  factory GamingDashBoardModel.fromJson(Map<String, dynamic> json) => GamingDashBoardModel(
    gameDashboard: json["gameDashboard"] == null ? null : GameDashboard.fromJson(json["gameDashboard"]),
    achievements: json["achievements"],
    dashboardAchievements: json["dashboardAchievements"],
  );

  Map<String, dynamic> toJson() => {
    "gameDashboard": gameDashboard?.toJson(),
    "achievements": achievements,
    "dashboardAchievements": dashboardAchievements,
  };
}

class GameDashboard {
  final String? id;
  final int? totalCarrots;
  final User? user;
  final int? level;
  final int? highScoreInFt;
  final int? numberOfGamesPlayed;
  final List<AchievedBadge>? achievedBadges;
  final int? v;

  GameDashboard({
    this.id,
    this.totalCarrots,
    this.user,
    this.level,
    this.highScoreInFt,
    this.numberOfGamesPlayed,
    this.achievedBadges,
    this.v,
  });

  factory GameDashboard.fromJson(Map<String, dynamic> json) => GameDashboard(
    id: json["_id"],
    totalCarrots: json["totalCarrots"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    level: json["level"],
    highScoreInFt: json["highScoreInFt"],
    numberOfGamesPlayed: json["numberOfGamesPlayed"],
    achievedBadges: json["achievedBadges"] == null ? [] : List<AchievedBadge>.from(json["achievedBadges"]!.map((x) => AchievedBadge.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "totalCarrots": totalCarrots,
    "user": user?.toJson(),
    "level": level,
    "highScoreInFt": highScoreInFt,
    "numberOfGamesPlayed": numberOfGamesPlayed,
    "achievedBadges": achievedBadges == null ? [] : List<dynamic>.from(achievedBadges!.map((x) => x.toJson())),
    "__v": v,
  };
}

class AchievedBadge {
  final String? skinType;
  final String? id;
  final String? name;
  final String? category;
  final String? description;
  final String? imgUrl;
  final int? targetValueInFt;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AchievedBadge({
    this.skinType,
    this.id,
    this.name,
    this.category,
    this.description,
    this.imgUrl,
    this.targetValueInFt,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AchievedBadge.fromJson(Map<String, dynamic> json) => AchievedBadge(
    skinType: json["skinType"],
    id: json["_id"],
    name: json["name"],
    category: json["category"],
    description: json["description"],
    imgUrl: json["imgUrl"],
    targetValueInFt: json["targetValueInFt"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "skinType": skinType,
    "_id": id,
    "name": name,
    "category": category,
    "description": description,
    "imgUrl": imgUrl,
    "targetValueInFt": targetValueInFt,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class User {
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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
