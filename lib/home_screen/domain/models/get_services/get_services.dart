import 'data.dart';

class GetServices {
  bool? success;
  Data? data;
  String? message;

  GetServices({this.success, this.data, this.message});

  factory GetServices.fromJson(Map<String, dynamic> json) => GetServices(
        success: json['success'] as bool?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
        'message': message,
      };
}
