import 'dart:convert';

List<Orders> ordersFromMap(String str) =>
    List<Orders>.from(json.decode(str).map((x) => Orders.fromMap(x)));

String ordersToMap(List<Orders> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Orders {
  Orders({
    this.id,
    this.isActive,
    this.price,
    this.company,
    this.picture,
    this.buyer,
    this.tags,
    this.status,
    this.registered,
  });

  String? id;
  bool? isActive;
  String? price;
  String? company;
  String? picture;
  String? buyer;
  List<String>? tags;
  Status? status;
  DateTime? registered;

  factory Orders.fromMap(Map<String, dynamic> json) => Orders(
        id: json["id"] == null ? null : json["id"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        price: json["price"] == null ? null : json["price"],
        company: json["company"] == null ? null : json["company"],
        picture: json["picture"] == null ? null : json["picture"],
        buyer: json["buyer"] == null ? null : json["buyer"],
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
        status:
            json["status"] == null ? null : statusValues.map![json["status"]],
        registered: json["registered"] == null
            ? null
            : DateTime.parse(json["registered"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "isActive": isActive == null ? null : isActive,
        "price": price == null ? null : price,
        "company": company == null ? null : company,
        "picture": picture == null ? null : picture,
        "buyer": buyer == null ? null : buyer,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "status": status == null ? null : statusValues.reverse[status],
        "registered": registered == null ? null : registered.toString(),
      };
}

enum Status { ORDERED, DELIVERED, RETURNED }

final statusValues = EnumValues({
  "DELIVERED": Status.DELIVERED,
  "ORDERED": Status.ORDERED,
  "RETURNED": Status.RETURNED
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
