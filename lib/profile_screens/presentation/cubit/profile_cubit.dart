import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/helper/local_data/shared_pref.dart';
import 'package:second_project/profile_screens/domain/models/get_profile_details.dart';
import 'package:second_project/profile_screens/domain/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profilerepo) : super(ProfileInitial());
  final Profilerepo profilerepo;
  void logOut() async {
    emit(LogOutLoading());
    final result = await profilerepo.logOut();
    result.fold(
      (faileur) {
        emit(LogOutFaileur(err: faileur.err.toString()));
      },
      (success) {
        CashedSharedPrefrances.deleteData(key: 'token');
        emit(LogOutsuccess());
      },
    );
  }

  void getProfileData() async {
    emit(GetProfileDataLoading());
    final result = await profilerepo.getProfileDetails();
    result.fold(
      (faileur) {
        emit(GetProfileDataFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(GetProfileDataSuccess(getProfileDetails: success));
      },
    );
  }

  void editProfileAndChangePassword({
    String? name,
    String? avatar,
    String? oldpassword,
    String? password,
    String? confirmPassword,
    String? email,
  }) async {
    emit(EditProfileAndChangePasswordLoading());
    final result = await profilerepo.editProfileAndChangePassword(
      avatar: avatar,
      email: email,
      name: name,
      oldPassword: oldpassword,
      password: password,
      passwordConfirmation: confirmPassword,
    );
    result.fold(
      (faileur) {
        emit(EditProfileAndChangePasswordFaileur(err: faileur.err.toString()));
      },
      (success) {
        getProfileData();
        emit(EditProfileAndChangePasswordsuccess());
      },
    );
  }
}
