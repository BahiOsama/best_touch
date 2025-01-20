import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:second_project/api/api_Services.dart';
import 'package:second_project/auth/domain/repos/auth_repo_impl.dart';
import 'package:second_project/home_screen/domain/repos/home_repo_impl.dart';
import 'package:second_project/profile_screens/domain/repos/profile_repo_impl.dart';

final getIt = GetIt.instance;

void getItSetUp() async {
  getIt.registerSingleton<ApiServices>(ApiServices(dio: Dio()));
//
//
//
//

  getIt.registerSingleton<AuthRepoImpl>(
      AuthRepoImpl(apiServices: getIt.get<ApiServices>()));

  getIt.registerSingleton<ProfileRepoImpl>(
      ProfileRepoImpl(apiServices: getIt.get<ApiServices>()));

  getIt.registerSingleton<HomeRepoImp>(
      HomeRepoImp(apiServices: getIt.get<ApiServices>()));
}
