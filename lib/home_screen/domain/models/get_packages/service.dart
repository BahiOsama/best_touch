class Service {
  int? id;
  String? name;
  String? description;
  String? image;
  int? price;
  int? discount;
  bool? hasDiscount;
  bool? hasPackage;

  Service({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.discount,
    this.hasDiscount,
    this.hasPackage,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        price: json['price'] as int?,
        discount: json['discount'] as int?,
        hasDiscount: json['has_discount'] as bool?,
        hasPackage: json['has_package'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'price': price,
        'discount': discount,
        'has_discount': hasDiscount,
        'has_package': hasPackage,
      };
}
