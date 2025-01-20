import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:second_project/api/api_Services.dart';
import 'package:second_project/auth/domain/models/auth_model.dart';
import 'package:second_project/auth/domain/models/chec_code_model.dart';
import 'package:second_project/auth/domain/repos/auth_repo.dart';
import 'package:second_project/helper/faileur.dart';
import 'package:second_project/helper/local_data/shared_pref.dart';

class AuthRepoImpl extends Authrepo {
  final ApiServices apiServices;

  AuthRepoImpl({required this.apiServices});

  @override
  Future<Either<Faileur, AuthModel>> register({
    required String name,
    dynamic long,
    dynamic lat,
    dynamic location,
    required String phone,
    required String password,
    required String rePassword,
  }) async {
    try {
      var data = await apiServices.post(
        endPoint: '/api/register',
        body: {
          'name': name,
          'location': location,
          'lat': lat,
          'long': long,
          'phone': phone,
          'password': password,
          'password_confirmation': rePassword,
          'device_token': 'mmmmmmmm'
        },
      );

      return right(AuthModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, AuthModel>> login({
    required String phone,
    required String password,
    required dynamic deviceToken,
  }) async {
    try {
      var data = await apiServices.post(
        endPoint: '/api/login',
        body: {
          'phone': phone,
          'password': password,
          'device_token': deviceToken,
        },
      );
      await CashedSharedPrefrances.insertToCash(
        key: 'token',
        value: data['data']['token'],
      );
      return right(AuthModel.fromJson(data['data']));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, Unit>> forgotPassword({required String phone}) async {
    try {
      await apiServices.post(
        endPoint: '/api/password/forget',
        body: {
          'phone': phone,
        },
      );
      return right(unit);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, CheckCodeModel>> checkCode(
      {required String phone, required String code}) async {
    try {
      var data = await apiServices.post(
        endPoint: '/api/password/code',
        body: {
          'phone': phone,
          'code': code,
        },
      );
      return right(CheckCodeModel.fromJson(data['data']));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, Unit>> resendPasswordResetCode(
      {required String phone}) async {
    try {
      await apiServices.post(
        endPoint: '/api/password/forget',
        body: {
          'phone': phone,
          'tybe': 'user',
        },
      );
      return right(unit);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, Unit>> resetPassword({
    required String token,
    required String password,
    required String passwordCofirm,
  }) async {
    try {
      await apiServices.post(
        endPoint: '/api/password/reset',
        body: {
          'token': token,
          'password': password,
          'password_confirmation': passwordCofirm,
        },
      );
      return right(unit);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, Unit>> veifiTheAcc(
      {required String phone, required String code}) async {
    try {
      await apiServices.post(
        endPoint: '/api/verification/verify',
        body: {
          'phone': phone,
          'code': code,
        },
      );
      return right(unit);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }
}
