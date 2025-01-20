import 'package:dartz/dartz.dart';
import 'package:second_project/helper/faileur.dart';
import 'package:second_project/home_screen/domain/models/car_size/car_size.dart';
import 'package:second_project/home_screen/domain/models/get_additions/get_additions.dart';
import 'package:second_project/home_screen/domain/models/get_banners/get_banners.dart';
import 'package:second_project/home_screen/domain/models/get_packages/get_packages.dart';
import 'package:second_project/home_screen/domain/models/get_services/get_services.dart';
import 'package:second_project/home_screen/domain/models/get_washers/get_washers.dart';
import 'package:second_project/home_screen/domain/models/notification_model.dart';
import 'package:second_project/home_screen/domain/models/washer_details/washer_details.dart';

abstract class HomeRepo {
  Future<Either<Faileur, List<NotificationModel>>> getNotification();
  Future<Either<Faileur, GetBanners>> getBanners();
  Future<Either<Faileur, GetWashers>> getWashers({
    String? search,
    int? page = 1,
    int? nearest,
    int? highRate,
    int? perPage,
    String? hasPackage,
    num? lat,
    num? long,
  });
  Future<Either<Faileur, GetWasherDetails>> getWaasherDetails({
    required int id,
  });
  Future<Either<Faileur, GetCarSize>> getCarsSizes();
  Future<Either<Faileur, GetServices>> getServices({
    required int size,
    required int washer,
  });
  Future<Either<Faileur, GetAdditions>> getAdditions();
  Future<Either<Faileur, GetPackages>> getPackages();
}
