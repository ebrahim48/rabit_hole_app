class ContactModel {
  final String? id;
  final String? email;
  final String? phone;
  final int? v;

  ContactModel({
    this.id,
    this.email,
    this.phone,
    this.v,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    id: json["_id"],
    email: json["email"],
    phone: json["phone"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "phone": phone,
    "__v": v,
  };
}
