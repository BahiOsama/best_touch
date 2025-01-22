import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:second_project/auth/data/google_map_services.dart';
import 'package:second_project/auth/data/location_services.dart';
import 'package:second_project/auth/data/routes_services.dart';
import 'package:second_project/auth/domain/models/place_auto_complete_model/place_auto_complete_model.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';
import 'package:second_project/widgets/textField.dart';
import 'package:uuid/uuid.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});
  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  late GoogleMapsPlacesServices googleMapsPlacesServices;
  late LocationService locationService;
  late TextEditingController textEditingController;
  late RoutesServices routesServices;
  late Uuid uuid;
  List<PlaceAutoCompleteModel> places = [];
  String? sessionToken;
  String? placeDetails;
  String currentAddress = '';
  LatLng? centerMarkerPosition;
  bool isMapReady = false;

  Set<Marker> myMarkers = {};
  @override
  void initState() {
    uuid = const Uuid();
    routesServices = RoutesServices();
    googleMapsPlacesServices = GoogleMapsPlacesServices();
    textEditingController = TextEditingController();
    locationService = LocationService();
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0), zoom: 5);
    fetchPredictions();
    super.initState();
  }

  void fetchPredictions() {
    textEditingController.addListener(
      () async {
        sessionToken ??= uuid.v4();
        print(sessionToken);
        if (textEditingController.text.isNotEmpty) {
          var result = await googleMapsPlacesServices.getPredictions(
            sessionToken: sessionToken!,
            input: textEditingController.text,
          );

          setState(() {
            places.clear();
            places.addAll(result);
          });
        } else {
          places.clear();
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 140,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Address'.tr()),
              Row(
                children: [
                  Image.asset(
                    AppImages.location,
                  ),
                  5.horizontalSpace,
                  Flexible(
                    child: Text(
                      currentAddress.isNotEmpty
                          ? currentAddress
                          : 'Fetching address...',
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              ConfirmOrGoBackk(
                onTap: isMapReady
                    ? () {
                        if (myMarkers.isNotEmpty) {
                          final markerPosition = myMarkers.first.position;
                          Navigator.pop(context, {
                            'latitude': markerPosition.latitude,
                            'longitude': markerPosition.longitude,
                            'address': currentAddress,
                          });
                        } else {
                          Navigator.pop(context, null);
                        }
                      }
                    : null,
                text: 'Set location'.tr(),
                height: 45,
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              markers: myMarkers,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (controller) {
                googleMapController = controller;
                updateCurrentLocation();
              },
              onCameraMove: (position) {
                setState(() {
                  myMarkers.add(
                    Marker(
                      markerId: const MarkerId('centerMarker'),
                      position: position.target,
                      icon: BitmapDescriptor.defaultMarker,
                    ),
                  );
                });
              },
              onCameraIdle: () async {
                try {
                  LatLngBounds visibleRegion =
                      await googleMapController.getVisibleRegion();
                  LatLng center = LatLng(
                    (visibleRegion.northeast.latitude +
                            visibleRegion.southwest.latitude) /
                        2,
                    (visibleRegion.northeast.longitude +
                            visibleRegion.southwest.longitude) /
                        2,
                  );

                  if (center.latitude.abs() < 0.01 &&
                      center.longitude.abs() < 0.01) {
                    setState(() {
                      currentAddress = 'Invalid location selected.';
                    });
                    return;
                  }

                  List<Placemark> placemarks = await placemarkFromCoordinates(
                    center.latitude,
                    center.longitude,
                  );

                  String address = placemarks.isNotEmpty
                      ? '${placemarks.first.name}, ${placemarks.first.locality}, ${placemarks.first.country}'
                      : 'Address not found';

                  setState(() {
                    currentAddress = address;
                    centerMarkerPosition = center;
                    myMarkers.add(
                      Marker(
                        markerId: const MarkerId('centerMarker'),
                        position: center,
                        icon: BitmapDescriptor.defaultMarker,
                      ),
                    );
                  });
                } catch (e) {
                  setState(() {
                    currentAddress =
                        'Unable to fetch address. Please try again.';
                  });
                  debugPrint('Reverse geocoding failed: $e');
                }
              },
            ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  TextFieldWidget(
                    obsecureText: false,
                    prefixIcon: Image.asset(AppImages.search),
                    textEditingController: textEditingController,
                    hintText: 'search for distrect,name,street'.tr(),
                  ),
                  Container(
                    decoration:
                        const BoxDecoration(color: AppColors.whiteColor),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        height: 0,
                      ),
                      itemCount: places.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            var placeDetails =
                                await googleMapsPlacesServices.getPlaceDetails(
                                    placeId: places[index].placeId.toString());
                            print(placeDetails);
                            textEditingController.clear();
                            sessionToken = null;
                            setState(() {});
                          },
                          leading: const Icon(FontAwesomeIcons.mapPin),
                          trailing: const Icon(Icons.arrow_circle_left_rounded),
                          title: Text(places[index].description!),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 18,
              top: 90,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: TextButton(
                    style: const ButtonStyle(
                        foregroundColor:
                            WidgetStatePropertyAll(AppColors.secondColor)),
                    onPressed: () {
                      Marker? userLocationMarker = myMarkers.firstWhere(
                        (marker) => marker.markerId.value == '1',
                      );

                      googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: userLocationMarker.position,
                            zoom: 10,
                          ),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.add_location_alt_sharp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateCurrentLocation() async {
    try {
      var locationData = await locationService.getLocation();
      final customIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(48, 48)),
        AppImages.facebook,
      );
      var camreaPosition = CameraPosition(
          target: LatLng(locationData.latitude!, locationData.longitude!),
          zoom: 10);
      var myLocationMarker = Marker(
        icon: customIcon,
        markerId: const MarkerId('1'),
        position: LatLng(
          locationData.latitude!,
          locationData.longitude!,
        ),
      );

      if (!mounted) return;

      myMarkers.add(myLocationMarker);
      List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );
      String address = placemarks.isNotEmpty
          ? '${placemarks.first.name}, ${placemarks.first.locality}, ${placemarks.first.country}'
          : 'Address not found';

      setState(() {
        currentAddress = address;
        isMapReady = true;
      });
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(camreaPosition),
      );
    } on LocationServiceExption catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Service Disabled'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on LocationPermitionExption catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permission Required'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                AppSettings.openAppSettings(type: AppSettingsType.location);
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
      );
    }
  }
}
