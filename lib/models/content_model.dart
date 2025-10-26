class ContentModel {
  final List<Content>? contents;
  final Overview? overview;
  final Meta? meta;

  ContentModel({
    this.contents,
    this.overview,
    this.meta,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
    contents: json["contents"] == null ? [] : List<Content>.from(json["contents"]!.map((x) => Content.fromJson(x))),
    overview: json["overview"] == null ? null : Overview.fromJson(json["overview"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "contents": contents == null ? [] : List<dynamic>.from(contents!.map((x) => x.toJson())),
    "overview": overview?.toJson(),
    "meta": meta?.toJson(),
  };
}

class Content {
  final String? id;
  final String? name;
  final Category? category;
  final String? description;
  final String? imgUrl;
  final int? timeInSec;
  final int? numberOfCarrot;
  final Status? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Content({
    this.id,
    this.name,
    this.category,
    this.description,
    this.imgUrl,
    this.timeInSec,
    this.numberOfCarrot,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    id: json["_id"],
    name: json["name"],
    category: categoryValues.map[json["category"]]!,
    description: json["description"],
    imgUrl: json["imgUrl"],
    timeInSec: json["timeInSec"],
    numberOfCarrot: json["numberOfCarrot"],
    status: statusValues.map[json["status"]]!,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "category": categoryValues.reverse[category],
    "description": description,
    "imgUrl": imgUrl,
    "timeInSec": timeInSec,
    "numberOfCarrot": numberOfCarrot,
    "status": statusValues.reverse[status],
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

enum Category {
  POWER_UP,
  SKIN
}

final categoryValues = EnumValues({
  "power-up": Category.POWER_UP,
  "skin": Category.SKIN
});

enum Status {
  ACTIVE
}

final statusValues = EnumValues({
  "active": Status.ACTIVE
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

class Overview {
  final int? totalContent;
  final int? totalSkin;
  final int? totalAchievement;
  final int? totalPowerUp;
  final int? totalObstacle;

  Overview({
    this.totalContent,
    this.totalSkin,
    this.totalAchievement,
    this.totalPowerUp,
    this.totalObstacle,
  });

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    totalContent: json["totalContent"],
    totalSkin: json["totalSkin"],
    totalAchievement: json["totalAchievement"],
    totalPowerUp: json["totalPowerUp"],
    totalObstacle: json["totalObstacle"],
  );

  Map<String, dynamic> toJson() => {
    "totalContent": totalContent,
    "totalSkin": totalSkin,
    "totalAchievement": totalAchievement,
    "totalPowerUp": totalPowerUp,
    "totalObstacle": totalObstacle,
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
