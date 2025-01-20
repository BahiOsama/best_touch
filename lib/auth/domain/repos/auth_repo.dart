import 'package:dartz/dartz.dart';
import 'package:second_project/auth/domain/models/auth_model.dart';
import 'package:second_project/auth/domain/models/chec_code_model.dart';
import 'package:second_project/helper/faileur.dart';

abstract class Authrepo {
  Future<Either<Faileur, AuthModel>> register({
    required String name,
    required String phone,
    required String password,
    required String rePassword,
    dynamic lat,
    dynamic long,
    dynamic location,
  });
  Future<Either<Faileur, AuthModel>> login({
    required String phone,
    required String password,
    required dynamic deviceToken,
  });
  Future<Either<Faileur, Unit>> forgotPassword({
    required String phone,
  });
  Future<Either<Faileur, CheckCodeModel>> checkCode({
    required String phone,
    required String code,
  });
  Future<Either<Faileur, Unit>> resendPasswordResetCode({
    required String phone,
  });
  Future<Either<Faileur, Unit>> resetPassword({
    required String token,
    required String password,
    required String passwordCofirm,
  });

  Future<Either<Faileur, Unit>> veifiTheAcc({
    required String phone,
    required String code,
  });
}
