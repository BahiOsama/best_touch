part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class LogOutLoading extends ProfileState {}

final class LogOutsuccess extends ProfileState {}

final class LogOutFaileur extends ProfileState {
  final String err;

  LogOutFaileur({required this.err});
}

final class GetProfileDataSuccess extends ProfileState {
  final GetProfileDetails getProfileDetails;

  GetProfileDataSuccess({required this.getProfileDetails});
}

final class GetProfileDataLoading extends ProfileState {}

final class GetProfileDataFaileur extends ProfileState {
  final String err;

  GetProfileDataFaileur({required this.err});
}

final class EditProfileAndChangePasswordLoading extends ProfileState {}

final class EditProfileAndChangePasswordsuccess extends ProfileState {}

final class EditProfileAndChangePasswordFaileur extends ProfileState {
  final String err;

  EditProfileAndChangePasswordFaileur({required this.err});
}
