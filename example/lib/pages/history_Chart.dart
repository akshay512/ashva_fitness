import 'dart:convert';

Img imgFromJson(String str) => Img.fromJson(json.decode(str));
String imgToJson(Img data) => json.encode(data.toJson());

class Img {
  String id;
  String img;


  Img({
    this.id,
    this.img,
    //this.decreption,
  });

  factory Img.fromJson(Map<String, dynamic> json) => Img(
    id: json["id"],
    img: json["img"],
    //decreption: json["decreption"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "img": img,
    //"decreption": decreption,
  };
}



class Tag {
  String name;
  String quantity;

  Tag(this.name, this.quantity);

  factory Tag.fromJson(dynamic json) {
    return Tag(json['name'] as String, json['quantity'] as String);
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.quantity} }';
  }
}

class Autogenerated {
  String wed;
  String thu;
  String fri;
  String sat;
  String sun;
  String mon;
  String tue;

  Autogenerated(
      {this.wed, this.thu, this.fri, this.sat, this.sun, this.mon, this.tue});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    wed = json['Wed'];
    thu = json['Thu'];
    fri = json['Fri'];
    sat = json['Sat'];
    sun = json['Sun'];
    mon = json['Mon'];
    tue = json['Tue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Wed'] = this.wed;
    data['Thu'] = this.thu;
    data['Fri'] = this.fri;
    data['Sat'] = this.sat;
    data['Sun'] = this.sun;
    data['Mon'] = this.mon;
    data['Tue'] = this.tue;
    return data;
  }
}
