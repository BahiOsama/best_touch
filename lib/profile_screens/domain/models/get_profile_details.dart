class GetProfileDetails {
  int? id;
  String? name;
  dynamic email;
  String? phone;
  String? lat;
  String? long;
  String? location;
  String? code;
  num? balance;
  String? avatar;
  String? deviceToken;
  String? token;
  String? resetToken;
  bool? verified;
  String? verifiedAt;
  String? createdAt;
  String? createdAtFormatted;

  GetProfileDetails({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.lat,
    this.long,
    this.location,
    this.code,
    this.balance,
    this.avatar,
    this.deviceToken,
    this.token,
    this.resetToken,
    this.verified,
    this.verifiedAt,
    this.createdAt,
    this.createdAtFormatted,
  });

  factory GetProfileDetails.fromJson(Map<String, dynamic> json) {
    return GetProfileDetails(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as dynamic,
      phone: json['phone'] as String?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      location: json['location'] as String?,
      code: json['code'] as String?,
      balance: json['balance'] as num?,
      avatar: json['avatar'] as String?,
      deviceToken: json['device_token'] as String?,
      token: json['token'] as String?,
      resetToken: json['reset_token'] as String?,
      verified: json['verified'] as bool?,
      verifiedAt: json['verified_at'] as String?,
      createdAt: json['created_at'] as String?,
      createdAtFormatted: json['created_at_formatted'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'lat': lat,
        'long': long,
        'location': location,
        'code': code,
        'balance': balance,
        'avatar': avatar,
        'device_token': deviceToken,
        'token': token,
        'reset_token': resetToken,
        'verified': verified,
        'verified_at': verifiedAt,
        'created_at': createdAt,
        'created_at_formatted': createdAtFormatted,
      };
}
