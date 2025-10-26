class ShopPackageModel {
  final List<Datum>? data;
  final Meta? meta;

  ShopPackageModel({
    this.data,
    this.meta,
  });

  factory ShopPackageModel.fromJson(Map<String, dynamic> json) => ShopPackageModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "meta": meta?.toJson(),
  };
}

class Datum {
  final String? id;
  final String? name;
  final Currency? currency;
  final double? price;
  final int? amount;
  final String? description;
  final Status? status;
  final int? v;

  Datum({
    this.id,
    this.name,
    this.currency,
    this.price,
    this.amount,
    this.description,
    this.status,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["name"],
    currency: currencyValues.map[json["currency"]]!,
    price: json["price"]?.toDouble(),
    amount: json["amount"],
    description: json["description"],
    status: statusValues.map[json["status"]]!,
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "currency": currencyValues.reverse[currency],
    "price": price,
    "amount": amount,
    "description": description,
    "status": statusValues.reverse[status],
    "__v": v,
  };
}

enum Currency {
  USD
}

final currencyValues = EnumValues({
  "USD": Currency.USD
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
