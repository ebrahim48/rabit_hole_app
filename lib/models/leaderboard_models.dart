class LeaderBoardModel {
  final List<Datum>? data;
  final List<Datum>? todayLeaderboard;
  final YourBestScore? yourBestScore;
  final Meta? meta;

  LeaderBoardModel({
    this.data,
    this.todayLeaderboard,
    this.yourBestScore,
    this.meta,
  });

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) => LeaderBoardModel(
    data: json["data"] == null
        ? []
        : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    todayLeaderboard: json["todayLeaderboard"] == null
        ? []
        : List<Datum>.from(json["todayLeaderboard"].map((x) => Datum.fromJson(x))),
    yourBestScore: json["yourBestScore"] == null
        ? null
        : YourBestScore.fromJson(json["yourBestScore"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "todayLeaderboard": todayLeaderboard == null
        ? []
        : List<dynamic>.from(todayLeaderboard!.map((x) => x.toJson())),
    "yourBestScore": yourBestScore?.toJson(),
    "meta": meta?.toJson(),
  };
}

class Datum {
  final String? id;
  final int? totalCarrots;
  final User? user;
  final int? level;
  final int? highScoreInFt;
  final int? numberOfGamesPlayed;

  Datum({
    this.id,
    this.totalCarrots,
    this.user,
    this.level,
    this.highScoreInFt,
    this.numberOfGamesPlayed,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    totalCarrots: json["totalCarrots"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    level: json["level"],
    highScoreInFt: json["highScoreInFt"],
    numberOfGamesPlayed: json["numberOfGamesPlayed"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "totalCarrots": totalCarrots,
    "user": user?.toJson(),
    "level": level,
    "highScoreInFt": highScoreInFt,
    "numberOfGamesPlayed": numberOfGamesPlayed,
  };
}

class User {
  final String? id;
  final int? totalCarrots;
  final String? fullName;
  final CurrentGametag? currentGametag;
  final String? profileImage;

  User({
    this.id,
    this.totalCarrots,
    this.fullName,
    this.currentGametag,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    totalCarrots: json["totalCarrots"],
    fullName: json["fullName"],
    currentGametag: currentGametagValues.map[json["CurrentGametag"]],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "totalCarrots": totalCarrots,
    "fullName": fullName,
    "CurrentGametag": currentGametagValues.reverse[currentGametag],
    "profileImage": profileImage,
  };
}

enum CurrentGametag { NEW_BIE }

final currentGametagValues = EnumValues({
  "NewBie": CurrentGametag.NEW_BIE,
});

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPage": totalPage,
  };
}

class YourBestScore {
  final String? id;
  final int? totalCarrots;
  final String? user;
  final int? level;
  final int? highScoreInFt;
  final int? numberOfGamesPlayed;
  final List<dynamic>? achievedBadges;
  final int? v;

  YourBestScore({
    this.id,
    this.totalCarrots,
    this.user,
    this.level,
    this.highScoreInFt,
    this.numberOfGamesPlayed,
    this.achievedBadges,
    this.v,
  });

  factory YourBestScore.fromJson(Map<String, dynamic> json) => YourBestScore(
    id: json["_id"],
    totalCarrots: json["totalCarrots"],
    user: json["user"],
    level: json["level"],
    highScoreInFt: json["highScoreInFt"],
    numberOfGamesPlayed: json["numberOfGamesPlayed"],
    achievedBadges: json["achievedBadges"] == null
        ? []
        : List<dynamic>.from(json["achievedBadges"].map((x) => x)),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "totalCarrots": totalCarrots,
    "user": user,
    "level": level,
    "highScoreInFt": highScoreInFt,
    "numberOfGamesPlayed": numberOfGamesPlayed,
    "achievedBadges": achievedBadges == null
        ? []
        : List<dynamic>.from(achievedBadges!.map((x) => x)),
    "__v": v,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
