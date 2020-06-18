import 'dart:convert';

MainModel mainModelFromMap(String str) => MainModel.fromMap(json.decode(str));

String mainModelToMap(MainModel data) => json.encode(data.toMap());

class MainModel {
    MainModel({
        this.id,
        this.title,
        this.img,
        this.interest,
        this.price,
        this.date,
        this.address,
        this.trainerName,
        this.trainerImg,
        this.trainerInfo,
        this.occasionDetail,
        this.latitude,
        this.longitude,
        this.isLiked,
        this.isSold,
        this.isPrivateEvent,
        this.hiddenCashPayment,
        this.specialForm,
        this.questionnaire,
        this.questExplanation,
        this.reservTypes,
    });

    int id;
    String title;
    List<String> img;
    String interest;
    int price;
    DateTime date;
    String address;
    String trainerName;
    String trainerImg;
    String trainerInfo;
    String occasionDetail;
    String latitude;
    String longitude;
    bool isLiked;
    bool isSold;
    bool isPrivateEvent;
    bool hiddenCashPayment;
    int specialForm;
    dynamic questionnaire;
    dynamic questExplanation;
    List<ReservType> reservTypes;

    factory MainModel.fromMap(Map<String, dynamic> json) => MainModel(
        id: json["id"],
        title: json["title"],
        img: List<String>.from(json["img"].map((x) => x)),
        interest: json["interest"],
        price: json["price"],
        date: DateTime.parse(json["date"]),
        address: json["address"],
        trainerName: json["trainerName"],
        trainerImg: json["trainerImg"],
        trainerInfo: json["trainerInfo"],
        occasionDetail: json["occasionDetail"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isLiked: json["isLiked"],
        isSold: json["isSold"],
        isPrivateEvent: json["isPrivateEvent"],
        hiddenCashPayment: json["hiddenCashPayment"],
        specialForm: json["specialForm"],
        questionnaire: json["questionnaire"],
        questExplanation: json["questExplanation"],
        reservTypes: List<ReservType>.from(json["reservTypes"].map((x) => ReservType.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "img": List<dynamic>.from(img.map((x) => x)),
        "interest": interest,
        "price": price,
        "date": date.toIso8601String(),
        "address": address,
        "trainerName": trainerName,
        "trainerImg": trainerImg,
        "trainerInfo": trainerInfo,
        "occasionDetail": occasionDetail,
        "latitude": latitude,
        "longitude": longitude,
        "isLiked": isLiked,
        "isSold": isSold,
        "isPrivateEvent": isPrivateEvent,
        "hiddenCashPayment": hiddenCashPayment,
        "specialForm": specialForm,
        "questionnaire": questionnaire,
        "questExplanation": questExplanation,
        "reservTypes": List<dynamic>.from(reservTypes.map((x) => x.toMap())),
    };
}

class ReservType {
    ReservType({
        this.id,
        this.name,
        this.count,
        this.price,
    });

    int id;
    String name;
    int count;
    int price;

    factory ReservType.fromMap(Map<String, dynamic> json) => ReservType(
        id: json["id"],
        name: json["name"],
        count: json["count"],
        price: json["price"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "count": count,
        "price": price,
    };
}