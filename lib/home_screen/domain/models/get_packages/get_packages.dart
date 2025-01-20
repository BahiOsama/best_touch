import 'data.dart';

class GetPackages {
  bool? success;
  Data? data;
  String? message;

  GetPackages({this.success, this.data, this.message});

  factory GetPackages.fromJson(Map<String, dynamic> json) => GetPackages(
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
