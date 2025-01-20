import 'datum.dart';

class GetAdditions {
  bool? success;
  List<Datum>? data;
  String? message;

  GetAdditions({this.success, this.data, this.message});

  factory GetAdditions.fromJson(Map<String, dynamic> json) => GetAdditions(
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
