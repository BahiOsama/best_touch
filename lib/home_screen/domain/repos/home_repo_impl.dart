import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:second_project/api/api_Services.dart';
import 'package:second_project/helper/faileur.dart';
import 'package:second_project/home_screen/domain/models/car_size/car_size.dart';
import 'package:second_project/home_screen/domain/models/get_additions/get_additions.dart';
import 'package:second_project/home_screen/domain/models/get_banners/get_banners.dart';
import 'package:second_project/home_screen/domain/models/get_packages/get_packages.dart';
import 'package:second_project/home_screen/domain/models/get_services/get_services.dart';
import 'package:second_project/home_screen/domain/models/get_washers/get_washers.dart';
import 'package:second_project/home_screen/domain/models/notification_model.dart';
import 'package:second_project/home_screen/domain/models/washer_details/washer_details.dart';
import 'package:second_project/home_screen/domain/repos/home_repo.dart';

class HomeRepoImp extends HomeRepo {
  final ApiServices apiServices;

  HomeRepoImp({required this.apiServices});

  @override
  Future<Either<Faileur, List<NotificationModel>>> getNotification() async {
    try {
      var data = await apiServices.get(
        endPoint: '/api/notifications',
      );
      List<dynamic> list = data['data']['data'];
      List<NotificationModel> notification = list
          .map(
            (e) => NotificationModel.fromJson(e),
          )
          .toList();
      return right(notification);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, GetBanners>> getBanners() async {
    try {
      var data = await apiServices.get(
        endPoint: '/api/advertisements',
      );
      return right(GetBanners.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, GetWashers>> getWashers({
    String? search,
    int? page = 1,
    int? nearest,
    int? highRate,
    int? perPage,
    String? hasPackage,
    num? lat,
    num? long,
  }) async {
    try {
      var data = await apiServices.get(
        queryParameters: {
          if (search != null) "search": search,
          if (page != null) "page": page,
          if (nearest != null) "nearest": nearest,
          if (highRate != null) "highRate": highRate,
          if (perPage != null) "perPage": perPage,
          if (hasPackage != null) "hasPackage": hasPackage,
          if (lat != null) "lat": lat,
          if (long != null) "long": long,
        },
        endPoint: '/api/washers?page=$page',
      );
      return right(GetWashers.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, GetWasherDetails>> getWaasherDetails(
      {required int id}) async {
    try {
      var data = await apiServices.get(
        endPoint: '/api/washers/$id',
      );
      return right(GetWasherDetails.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, GetCarSize>> getCarsSizes() async {
    try {
      var data = await apiServices.get(
        endPoint: '/api/sizes',
      );
      return right(GetCarSize.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, GetServices>> getServices(
      {required int size, required int washer}) async {
    try {
      var data = await apiServices.get(
        endPoint: '/api/services?size=$size&washer=$washer',
      );
      return right(GetServices.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, GetAdditions>> getAdditions() async {
    try {
      var data = await apiServices.get(
        endPoint: '/api/additions',
      );
      return right(GetAdditions.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }

  @override
  Future<Either<Faileur, GetPackages>> getPackages() async {
    try {
      var data = await apiServices.get(
        endPoint: '/api/packages',
      );
      return right(GetPackages.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFaileur.fromDioError(e));
      }
      return left(ServerFaileur(err: e.toString()));
    }
  }
}
