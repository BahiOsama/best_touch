class Data {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? description;
  String? code;
  int? rate;
  String? image;
  List<dynamic>? banners;
  dynamic deviceToken;
  dynamic address;
  dynamic lat;
  dynamic long;
  bool? isNearest;
  String? token;
  String? resetToken;
  bool? verified;
  String? verifiedAt;
  String? createdAt;
  String? createdAtFormatted;

  Data({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.description,
    this.code,
    this.rate,
    this.image,
    this.banners,
    this.deviceToken,
    this.address,
    this.lat,
    this.long,
    this.isNearest,
    this.token,
    this.resetToken,
    this.verified,
    this.verifiedAt,
    this.createdAt,
    this.createdAtFormatted,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        description: json['description'] as String?,
        code: json['code'] as String?,
        rate: json['rate'] as int?,
        image: json['image'] as String?,
        banners: json['banners'] as List<dynamic>?,
        deviceToken: json['device_token'] as dynamic,
        address: json['address'] as dynamic,
        lat: json['lat'] as dynamic,
        long: json['long'] as dynamic,
        isNearest: json['isNearest'] as bool?,
        token: json['token'] as String?,
        resetToken: json['reset_token'] as String?,
        verified: json['verified'] as bool?,
        verifiedAt: json['verified_at'] as String?,
        createdAt: json['created_at'] as String?,
        createdAtFormatted: json['created_at_formatted'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'description': description,
        'code': code,
        'rate': rate,
        'image': image,
        'banners': banners,
        'device_token': deviceToken,
        'address': address,
        'lat': lat,
        'long': long,
        'isNearest': isNearest,
        'token': token,
        'reset_token': resetToken,
        'verified': verified,
        'verified_at': verifiedAt,
        'created_at': createdAt,
        'created_at_formatted': createdAtFormatted,
      };
}
