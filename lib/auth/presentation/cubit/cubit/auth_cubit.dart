import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/auth/domain/models/auth_model.dart';
import 'package:second_project/auth/domain/models/chec_code_model.dart';
import 'package:second_project/auth/domain/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authrepo) : super(AuthInitial());
  final Authrepo authrepo;
  void register({
    required String name,
    dynamic lat,
    dynamic long,
    dynamic location,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    emit(AuthRegistLoading());
    final result = await authrepo.register(
        lat: lat,
        location: location,
        long: long,
        name: name,
        phone: phone,
        password: password,
        rePassword: rePassword);
    result.fold(
      (faileur) {
        emit(AuthRegistFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(AuthRegistSuccess(authModel: success));
      },
    );
  }

  void login({
    required String password,
    required String phone,
    required dynamic deviceToken,
  }) async {
    emit(AuthLoginLoading());
    final result = await authrepo.login(
      deviceToken: deviceToken,
      phone: phone,
      password: password,
    );
    result.fold(
      (faileur) {
        emit(AuthLoginFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(AuthLoginSuccess(authModel: success));
      },
    );
  }

  void forgetPassword({
    required String phone,
  }) async {
    emit(AuthforgotPasswordLoading());
    final result = await authrepo.forgotPassword(phone: phone);
    result.fold(
      (faileur) {
        emit(AuthforgotPasswordFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(AuthforgotPasswordSuccess());
      },
    );
  }

  void chechCode({
    required String phone,
    required String code,
  }) async {
    emit(AuthCheckCodeLoading());
    final result = await authrepo.checkCode(phone: phone, code: code);
    result.fold(
      (faileur) {
        emit(AuthCheckCodeFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(AuthCheckCodeSuccess(checkCodemModel: success));
      },
    );
  }

  void resendResetCode({
    required String phone,
  }) async {
    emit(AuthResendResetCodeLoading());
    final result = await authrepo.resendPasswordResetCode(
      phone: phone,
    );
    result.fold(
      (faileur) {
        emit(AuthResendResetCodeFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(AuthResendResetCodeSuccess());
      },
    );
  }

  void resetPassword({
    required String password,
    required String passwordConfirm,
    required String token,
  }) async {
    emit(AuthResetPasswordLoading());
    final result = await authrepo.resetPassword(
        password: password, passwordCofirm: passwordConfirm, token: token);
    result.fold(
      (faileur) {
        emit(AuthResetPasswordFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(AuthResetPasswordSuccess());
      },
    );
  }

  void verifiTheAcc({
    required String phone,
    required String code,
  }) async {
    emit(SendVerificationCodeLoading());
    final result = await authrepo.veifiTheAcc(
      code: code,
      phone: phone,
    );
    result.fold(
      (faileur) {
        emit(SendVerificationCodeFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(SendVerificationCodeSuccess());
      },
    );
  }
}
