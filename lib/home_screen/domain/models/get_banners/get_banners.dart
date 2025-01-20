import 'datum.dart';

class GetBanners {
  bool? success;
  List<Datum>? data;
  String? message;

  GetBanners({this.success, this.data, this.message});

  factory GetBanners.fromJson(Map<String, dynamic> json) => GetBanners(
        success: json['success'] as bool?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.map((e) => e.toJson()).toList(),
        'message': message,
      };
}
