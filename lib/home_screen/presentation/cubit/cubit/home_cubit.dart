import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/home_screen/domain/models/car_size/car_size.dart';
import 'package:second_project/home_screen/domain/models/get_additions/get_additions.dart';
import 'package:second_project/home_screen/domain/models/get_banners/get_banners.dart';
import 'package:second_project/home_screen/domain/models/get_packages/get_packages.dart';
import 'package:second_project/home_screen/domain/models/get_services/get_services.dart';
import 'package:second_project/home_screen/domain/models/get_washers/get_washers.dart';
import 'package:second_project/home_screen/domain/models/notification_model.dart';
import 'package:second_project/home_screen/domain/models/washer_details/washer_details.dart';
import 'package:second_project/home_screen/domain/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit(this.homeRepo) : super(HomeScreenInitial());

  final HomeRepo homeRepo;
  void getNotification() async {
    emit(GetNotificationLoading());
    final result = await homeRepo.getNotification();
    result.fold(
      (faileur) {
        emit(GetNotificationFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(GetNotificationsuccess(notificationModel: success));
      },
    );
  }

  void getBanners() async {
    emit(GetBannersLoading());
    final result = await homeRepo.getBanners();
    result.fold(
      (faileur) {
        emit(GetBannersFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(GetBannersSuccess(getBanners: success));
      },
    );
  }

  Future<void> getWashers({
    String? search,
    int? page = 1,
    int? nearest,
    int? highRate,
    int? perPage,
    String? hasPackage,
    num? lat,
    num? long,
  }) async {
    emit(GetWaherssLoading());
    final result = await homeRepo.getWashers(
      hasPackage: hasPackage,
      highRate: highRate,
      lat: lat,
      long: long,
      nearest: nearest,
      page: page,
      perPage: perPage,
      search: search,
    );
    result.fold(
      (faileur) {
        emit(GetWaherssFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(GetWaherssuccess(getWashers: success));
      },
    );
  }

  void getWasherDetails({required int id}) async {
    emit(GetWasherDetailsLoading());
    final result = await homeRepo.getWaasherDetails(id: id);
    result.fold(
      (faileur) {
        emit(GetWasherDetailsFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(GetWasherDetailsLSuccess(getWasherDetails: success));
      },
    );
  }

  void getCarsSizes() async {
    emit(GetCarSizeLoading());
    final result = await homeRepo.getCarsSizes();
    result.fold(
      (faileur) {
        emit(GetCarSizeFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(GetCarSizeSuccess(getCarSize: success));
      },
    );
  }

  void getCarsServices({required int sizeid, required int washer}) async {
    emit(GetCarServicesLoading());
    final result = await homeRepo.getServices(
      size: sizeid,
      washer: washer,
    );
    result.fold(
      (faileur) {
        emit(GetCarServicesFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(GetCarServicesSuccess(getServices: success));
      },
    );
  }

  void getAdditions() async {
    emit(GetAdditionsLoading());
    final result = await homeRepo.getAdditions();
    result.fold(
      (faileur) {
        emit(GetAdditionsFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(GetAdditionsSuccess(getAdditions: success));
      },
    );
  }

  void getAPackages() async {
    emit(GetPackagesLoading());
    final result = await homeRepo.getPackages();
    result.fold(
      (faileur) {
        emit(GetPackagesFaileur(err: faileur.err.toString()));
      },
      (success) {
        emit(GetPackagesSuccess(getPackages: success));
      },
    );
  }
}
