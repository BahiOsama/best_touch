import 'service.dart';
import 'size.dart';
import 'washer.dart';

class Datum {
  int? id;
  String? name;
  String? description;
  Service? service;
  Size? size;
  List<Washer>? washers;
  int? price;
  int? oldPrice;
  bool? hasOldPrice;

  Datum({
    this.id,
    this.name,
    this.description,
    this.service,
    this.size,
    this.washers,
    this.price,
    this.oldPrice,
    this.hasOldPrice,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        service: json['service'] == null
            ? null
            : Service.fromJson(json['service'] as Map<String, dynamic>),
        size: json['size'] == null
            ? null
            : Size.fromJson(json['size'] as Map<String, dynamic>),
        washers: (json['washers'] as List<dynamic>?)
            ?.map((e) => Washer.fromJson(e as Map<String, dynamic>))
            .toList(),
        price: json['price'] as int?,
        oldPrice: json['old_price'] as int?,
        hasOldPrice: json['has_old_price'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'service': service?.toJson(),
        'size': size?.toJson(),
        'washers': washers?.map((e) => e.toJson()).toList(),
        'price': price,
        'old_price': oldPrice,
        'has_old_price': hasOldPrice,
      };
}
