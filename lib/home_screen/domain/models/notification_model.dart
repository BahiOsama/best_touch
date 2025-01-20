class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type;
  final String? targetModel;
  final String targetType;
  final String targetId;
  final bool isRead;
  final String creationTime;
  final String createdAtFormatted;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    this.targetModel,
    required this.targetType,
    required this.targetId,
    required this.isRead,
    required this.creationTime,
    required this.createdAtFormatted,
  });

  // Factory method to create a model from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      targetModel: json['target_model'],
      targetType: json['target_type'],
      targetId: json['target_id'],
      isRead: json['is_read'],
      creationTime: json['creation_time'],
      createdAtFormatted: json['created_at_formatted'],
    );
  }

  // Method to convert a model instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'target_model': targetModel,
      'target_type': targetType,
      'target_id': targetId,
      'is_read': isRead,
      'creation_time': creationTime,
      'created_at_formatted': createdAtFormatted,
    };
  }
}

class TargetModel {
  final int id;
  final String status;
  final double servicePrice;
  final double additionTotalPrice;
  final double subTotal;
  final double tax;
  final double total;
  final double serviceDiscount;
  final bool hasServiceDiscount;
  final double couponDiscount;
  final bool hasCouponDiscount;
  final String createdAt;
  final String updatedAt;
  final String createdAtFormatted;
  final String updatedAtFormatted;
  final List<dynamic> payments;
  final User user;
  final Washer washer;
  final Service service;
  final Coupon? coupon;
  final Size size;
  final List<Addition> additions;
  final List<dynamic> taxes;
  final dynamic reason;
  final bool hasValidPackage;
  final bool paidByReward;
  final bool paidByPackage;
  final Vehicle vehicle;

  TargetModel({
    required this.id,
    required this.status,
    required this.servicePrice,
    required this.additionTotalPrice,
    required this.subTotal,
    required this.tax,
    required this.total,
    required this.serviceDiscount,
    required this.hasServiceDiscount,
    required this.couponDiscount,
    required this.hasCouponDiscount,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFormatted,
    required this.updatedAtFormatted,
    required this.payments,
    required this.user,
    required this.washer,
    required this.service,
    this.coupon,
    required this.size,
    required this.additions,
    required this.taxes,
    this.reason,
    required this.hasValidPackage,
    required this.paidByReward,
    required this.paidByPackage,
    required this.vehicle,
  });

  factory TargetModel.fromJson(Map<String, dynamic> json) {
    return TargetModel(
      id: json['id'],
      status: json['status'],
      servicePrice: json['servicePrice'].toDouble(),
      additionTotalPrice: json['additionTotalPrice'].toDouble(),
      subTotal: json['subTotal'].toDouble(),
      tax: json['tax'].toDouble(),
      total: json['total'].toDouble(),
      serviceDiscount: json['serviceDiscount'].toDouble(),
      hasServiceDiscount: json['hasServiceDiscount'],
      couponDiscount: json['couponDiscount'].toDouble(),
      hasCouponDiscount: json['hasCouponDiscount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      createdAtFormatted: json['createdAtFormatted'],
      updatedAtFormatted: json['updatedAtFormatted'],
      payments: json['payments'],
      user: User.fromJson(json['user']),
      washer: Washer.fromJson(json['washer']),
      service: Service.fromJson(json['service']),
      coupon: json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null,
      size: Size.fromJson(json['size']),
      additions: (json['additions'] as List)
          .map((addition) => Addition.fromJson(addition))
          .toList(),
      taxes: json['taxes'],
      reason: json['reason'],
      hasValidPackage: json['hasValidPackage'],
      paidByReward: json['paidByReward'],
      paidByPackage: json['paidByPackage'],
      vehicle: Vehicle.fromJson(json['vehicle']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String phone;
  final String verificationCode;
  final String email;
  final String avatar;
  final double balance;
  final String lat;
  final String long;
  final String location;
  final String createdAt;
  final String createdAtFormatted;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.verificationCode,
    required this.email,
    required this.avatar,
    required this.balance,
    required this.lat,
    required this.long,
    required this.location,
    required this.createdAt,
    required this.createdAtFormatted,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      verificationCode: json['verification_code'],
      email: json['email'],
      avatar: json['avatar'],
      balance: json['balance'].toDouble(),
      lat: json['lat'],
      long: json['long'],
      location: json['location'],
      createdAt: json['created_at'],
      createdAtFormatted: json['created_at_formatted'],
    );
  }
}

class Washer {
  final int id;
  final String name;
  final String image;
  final String description;
  final String address;
  final double rate;
  final double distance;
  final bool hasPackage;

  Washer({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.address,
    required this.rate,
    required this.distance,
    required this.hasPackage,
  });

  factory Washer.fromJson(Map<String, dynamic> json) {
    return Washer(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      address: json['address'],
      rate: json['rate'].toDouble(),
      distance: json['distance'].toDouble(),
      hasPackage: json['has_package'],
    );
  }
}

class Service {
  final int id;
  final String name;
  final String description;
  final String image;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}

class Coupon {
  // Assuming there are some coupon fields, adjust as per your requirements
  final int? id;
  final String? code;

  Coupon({
    this.id,
    this.code,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      code: json['code'],
    );
  }
}

class Size {
  final int id;
  final String name;
  final String description;
  final String image;
  final bool hasPackage;

  Size({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.hasPackage,
  });

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      hasPackage: json['has_package'],
    );
  }
}

class Addition {
  final int id;
  final String name;
  final int quantity;
  final double price;
  final String image;

  Addition({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
  });

  factory Addition.fromJson(Map<String, dynamic> json) {
    return Addition(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}

class Vehicle {
  final List<String> images;
  final UserVehicle userVehicle;

  Vehicle({
    required this.images,
    required this.userVehicle,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      images: List<String>.from(json['images']),
      userVehicle: UserVehicle.fromJson(json['userVehicle']),
    );
  }
}

class UserVehicle {
  final String brand;
  final String model;
  final int number;
  final String letter;

  UserVehicle({
    required this.brand,
    required this.model,
    required this.number,
    required this.letter,
  });

  factory UserVehicle.fromJson(Map<String, dynamic> json) {
    return UserVehicle(
      brand: json['brand'],
      model: json['model'],
      number: json['number'],
      letter: json['letter'],
    );
  }
}
