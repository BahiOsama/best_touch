import 'package:dartz/dartz.dart';
import 'package:second_project/helper/faileur.dart';
import 'package:second_project/profile_screens/domain/models/get_profile_details.dart';

abstract class Profilerepo {
  Future<Either<Faileur, Unit>> logOut();
  Future<Either<Faileur, GetProfileDetails>> getProfileDetails();
  Future<Either<Faileur, void>> editProfileAndChangePassword(
      {String? name,
      String? avatar,
      String? oldPassword,
      String? password,
      String? passwordConfirmation,
      String? email});
}
