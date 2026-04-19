import 'package:flutter/services.dart';

class DeviceLocationException implements Exception {
  const DeviceLocationException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => message;
}

class DeviceLocation {
  const DeviceLocation({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;
}

class DeviceLocationService {
  static const _channel = MethodChannel('net.carcoop.app/location');

  Future<bool> hasPermission() async {
    return (await _channel.invokeMethod<bool>('checkPermission')) ?? false;
  }

  Future<bool> requestPermission() async {
    return (await _channel.invokeMethod<bool>('requestPermission')) ?? false;
  }

  Future<DeviceLocation> getCurrentLocation() async {
    try {
      final result =
          await _channel.invokeMapMethod<String, dynamic>('getCurrentPosition');
      if (result == null) {
        throw const DeviceLocationException(
          'UNAVAILABLE',
          'Location is unavailable.',
        );
      }

      final latitude = result['latitude'];
      final longitude = result['longitude'];
      if (latitude is! num || longitude is! num) {
        throw const DeviceLocationException(
          'UNAVAILABLE',
          'Location is unavailable.',
        );
      }

      return DeviceLocation(
        latitude: latitude.toDouble(),
        longitude: longitude.toDouble(),
      );
    } on PlatformException catch (error) {
      throw DeviceLocationException(
        error.code,
        error.message ?? 'Location is unavailable.',
      );
    }
  }
}
