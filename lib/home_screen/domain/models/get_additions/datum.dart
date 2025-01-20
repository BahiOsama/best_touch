class Datum {
  int? id;
  String? name;
  int? price;
  bool? isFree;
  String? image;

  Datum({this.id, this.name, this.price, this.isFree, this.image});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        price: json['price'] as int?,
        isFree: json['isFree'] as bool?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'isFree': isFree,
        'image': image,
      };
}
