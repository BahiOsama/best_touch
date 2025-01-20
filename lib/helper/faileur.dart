import 'package:dio/dio.dart';

abstract class Faileur {
  final String err;

  Faileur({required this.err});
}

class ServerFaileur extends Faileur {
  ServerFaileur({required super.err});

  factory ServerFaileur.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFaileur(err: 'Connection Time With Api Server');
      case DioExceptionType.sendTimeout:
        return ServerFaileur(err: 'Send Timeout With Api Server');
      case DioExceptionType.receiveTimeout:
        return ServerFaileur(err: 'Recieve Timeout With Api Server');
      case DioExceptionType.badCertificate:
        return ServerFaileur(err: 'badCertificate');
      case DioExceptionType.badResponse:
        return ServerFaileur.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data!);
      case DioExceptionType.cancel:
        return ServerFaileur(err: 'Request To Api Server Was Canceled');
      case DioExceptionType.connectionError:
        return ServerFaileur(err: 'Connection Error');
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFaileur(err: 'No Internet Connection');
        }
        return ServerFaileur(err: 'UnExpected Error , Please Try Later');
      default:
        return ServerFaileur(err: 'UnExpected Error , Please Try Later');
    }
  }
  factory ServerFaileur.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFaileur(
          err: response['errors'].toString() == "null"
              ? response['message'].toString()
              : response['errors'].toString());
    } else if (statusCode == 404) {
      return ServerFaileur(err: 'Your Request Not Found Please Try Again ..');
    } else if (statusCode == 500) {
      return ServerFaileur(err: 'Internal Server Error , Please Try Again');
    } else {
      return ServerFaileur(err: 'Sorry There were an Error');
    }
  }
}
