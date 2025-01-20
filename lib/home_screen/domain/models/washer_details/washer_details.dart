import 'data.dart';

class GetWasherDetails {
  bool? success;
  Data? data;
  String? message;

  GetWasherDetails({this.success, this.data, this.message});

  factory GetWasherDetails.fromJson(Map<String, dynamic> json) =>
      GetWasherDetails(
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
