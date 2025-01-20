part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthRegistLoading extends AuthState {}

final class AuthRegistFaileur extends AuthState {
  final String err;

  AuthRegistFaileur({required this.err});
}

final class AuthRegistSuccess extends AuthState {
  final AuthModel authModel;

  AuthRegistSuccess({required this.authModel});
}

final class AuthLoginLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  final AuthModel authModel;

  AuthLoginSuccess({required this.authModel});
}

final class AuthLoginFaileur extends AuthState {
  final String err;

  AuthLoginFaileur({required this.err});
}

final class AuthforgotPasswordSuccess extends AuthState {}

final class AuthforgotPasswordLoading extends AuthState {}

final class AuthforgotPasswordFaileur extends AuthState {
  final String err;

  AuthforgotPasswordFaileur({required this.err});
}

final class AuthCheckCodeSuccess extends AuthState {
  final CheckCodeModel checkCodemModel;

  AuthCheckCodeSuccess({required this.checkCodemModel});
}

final class AuthCheckCodeLoading extends AuthState {}

final class AuthCheckCodeFaileur extends AuthState {
  final String err;

  AuthCheckCodeFaileur({required this.err});
}

final class AuthResendResetCodeLoading extends AuthState {}

final class AuthResendResetCodeSuccess extends AuthState {}

final class AuthResendResetCodeFaileur extends AuthState {
  final String err;

  AuthResendResetCodeFaileur({required this.err});
}

final class AuthResetPasswordSuccess extends AuthState {}

final class AuthResetPasswordLoading extends AuthState {}

final class AuthResetPasswordFaileur extends AuthState {
  final String err;

  AuthResetPasswordFaileur({required this.err});
}

final class SendVerificationCodeLoading extends AuthState {}

final class SendVerificationCodeFaileur extends AuthState {
  final String err;

  SendVerificationCodeFaileur({required this.err});
}

final class SendVerificationCodeSuccess extends AuthState {}
