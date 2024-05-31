part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();
}

class GpsAndPermissionEvent extends GpsEvent{
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  const GpsAndPermissionEvent({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted
  });

  @override
  // TODO: implement props
  List<Object?> get props => [isGpsEnabled, isGpsPermissionGranted];
}
