part of 'home_cubit.dart';

@immutable
sealed class HomeCubitState {}

final class HomeScreenInitial extends HomeCubitState {}

final class GetNotificationLoading extends HomeCubitState {}

final class GetNotificationsuccess extends HomeCubitState {
  final List<NotificationModel> notificationModel;

  GetNotificationsuccess({required this.notificationModel});
}

final class GetNotificationFaileur extends HomeCubitState {
  final String err;

  GetNotificationFaileur({required this.err});
}

final class GetBannersLoading extends HomeCubitState {}

final class GetBannersSuccess extends HomeCubitState {
  final GetBanners getBanners;

  GetBannersSuccess({required this.getBanners});
}

final class GetBannersFaileur extends HomeCubitState {
  final String err;

  GetBannersFaileur({required this.err});
}

final class GetWaherssLoading extends HomeCubitState {}

final class GetWaherssFaileur extends HomeCubitState {
  final String err;

  GetWaherssFaileur({required this.err});
}

final class GetWaherssuccess extends HomeCubitState {
  final GetWashers getWashers;

  GetWaherssuccess({required this.getWashers});
}

final class GetWasherDetailsLoading extends HomeCubitState {}

final class GetWasherDetailsLSuccess extends HomeCubitState {
  final GetWasherDetails getWasherDetails;

  GetWasherDetailsLSuccess({required this.getWasherDetails});
}

final class GetWasherDetailsFaileur extends HomeCubitState {
  final String err;

  GetWasherDetailsFaileur({required this.err});
}

final class GetCarSizeLoading extends HomeCubitState {}

final class GetCarSizeFaileur extends HomeCubitState {
  final String err;

  GetCarSizeFaileur({required this.err});
}

final class GetCarSizeSuccess extends HomeCubitState {
  final GetCarSize getCarSize;

  GetCarSizeSuccess({required this.getCarSize});
}

final class GetCarServicesLoading extends HomeCubitState {}

final class GetCarServicesFaileur extends HomeCubitState {
  final String err;

  GetCarServicesFaileur({required this.err});
}

final class GetCarServicesSuccess extends HomeCubitState {
  final GetServices getServices;

  GetCarServicesSuccess({required this.getServices});
}

final class GetAdditionsLoading extends HomeCubitState {}

final class GetAdditionsFaileur extends HomeCubitState {
  final String err;

  GetAdditionsFaileur({required this.err});
}

final class GetAdditionsSuccess extends HomeCubitState {
  final GetAdditions getAdditions;

  GetAdditionsSuccess({required this.getAdditions});
}

final class GetPackagesLoading extends HomeCubitState {}

final class GetPackagesFaileur extends HomeCubitState {
  final String err;

  GetPackagesFaileur({required this.err});
}

final class GetPackagesSuccess extends HomeCubitState {
  final GetPackages getPackages;

  GetPackagesSuccess({required this.getPackages});
}
