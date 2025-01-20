import 'data.dart';

class GetWashers {
  bool? success;
  Data? data;
  String? message;

  GetWashers({this.success, this.data, this.message});

  factory GetWashers.fromJson(Map<String, dynamic> json) => GetWashers(
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
