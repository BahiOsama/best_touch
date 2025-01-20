import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:second_project/api/api_Services.dart';
import 'package:second_project/helper/faileur.dart';
import 'package:second_project/profile_screens/domain/models/get_profile_details.dart';
import 'package:second_project/profile_screens/domain/repos/profile_repo.dart';

class ProfileRepoImpl extends Profilerepo {
  final ApiServices apiServices;

  ProfileRepoImpl({required this.apiServices});

  @override
  Future<Either<Faileur, Unit>> logOut() async {
    try {
      await apiServices.post(
        endPoint: '/api/logout',
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
  Future<Either<Faileur, GetProfileDetails>> getProfileDetails() async {
    try {
      var data = await apiServices.get(
        endPoint: '/api/profile',
      );

      return right(GetProfileDetails.fromJson(data['data']));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, void>> editProfileAndChangePassword({
    String? name,
    String? avatar,
    String? oldPassword,
    String? password,
    String? passwordConfirmation,
    String? email,
  }) async {
    try {
      await apiServices.post(
        body: {
          if (name != null) "name": name,
          if (avatar != null) "avatar": avatar,
          if (email != null) "email": email,
          if (oldPassword != null &&
              password != null &&
              passwordConfirmation != null) ...{
            "old_password": oldPassword,
            "password": password,
            " password_confirmation": passwordConfirmation,
          },
        },
        endPoint: '/api/profile',
      );
      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }
}
