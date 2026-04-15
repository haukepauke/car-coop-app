import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../../data/api/parking_api.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/car_provider.dart';
import '../../../providers/parking_provider.dart';
import '../../widgets/common/async_value_widget.dart';
import '../../widgets/common/app_message_dialog.dart';
import '../../widgets/common/page_header.dart';

class _ParkingTileCacheManager extends CacheManager {
  _ParkingTileCacheManager._()
      : super(
          Config(
            'parking-osm-tiles',
            stalePeriod: const Duration(days: 14),
            maxNrOfCacheObjects: 300,
          ),
        );

  static final instance = _ParkingTileCacheManager._();
}

class _CachedTileProvider extends TileProvider {
  _CachedTileProvider()
      : super(
          headers: const {
            'User-Agent': 'com.carcoop.app',
          },
        );

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    final url = getTileUrl(coordinates, options);
    return CachedNetworkImageProvider(
      url,
      headers: headers,
      cacheManager: _ParkingTileCacheManager.instance,
      cacheKey: url,
    );
  }
}

class ParkingScreen extends ConsumerStatefulWidget {
  const ParkingScreen({super.key});

  @override
  ConsumerState<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends ConsumerState<ParkingScreen> {
  final _mapController = MapController();
  bool _saving = false;
  String? _lastPrefetchedKey;

  Future<void> _prefetchTilesAround(LatLng center, {int zoom = 15}) async {
    final key = '${center.latitude.toStringAsFixed(5)},'
        '${center.longitude.toStringAsFixed(5)}@$zoom';
    if (_lastPrefetchedKey == key) return;
    _lastPrefetchedKey = key;

    final tile = _latLngToTile(center, zoom);
    final futures = <Future<void>>[];
    for (var dx = -1; dx <= 1; dx++) {
      for (var dy = -1; dy <= 1; dy++) {
        final x = tile.x + dx;
        final y = tile.y + dy;
        final url = 'https://tile.openstreetmap.org/$zoom/$x/$y.png';
        futures.add(
          _ParkingTileCacheManager.instance
              .downloadFile(url, key: url)
              .then((_) {})
              .catchError((_) {}),
        );
      }
    }

    await Future.wait(futures);
  }

  math.Point<int> _latLngToTile(LatLng latLng, int zoom) {
    final scale = 1 << zoom;
    final x = ((latLng.longitude + 180.0) / 360.0 * scale).floor();
    final latRad = latLng.latitude * math.pi / 180.0;
    final y = ((1 -
                math.log(
                      math.tan(latRad) + 1 / math.cos(latRad),
                    ) /
                    math.pi) /
            2 *
            scale)
        .floor();
    return math.Point<int>(x, y);
  }

  Future<void> _navigateTo(double lat, double lng) async {
    final l10n = AppLocalizations.of(context)!;
    final uri = Uri.parse('geo:$lat,$lng?q=$lat,$lng');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        await showAppMessageDialog(
          context,
          message: l10n.couldNotOpenNav,
          type: AppMessageType.error,
        );
      }
    }
  }

  Future<void> _setCurrentLocation() async {
    final l10n = AppLocalizations.of(context)!;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (mounted) {
        await showAppMessageDialog(
          context,
          message: l10n.locationPermissionRequired,
          type: AppMessageType.warning,
        );
      }
      return;
    }

    setState(() => _saving = true);
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
        ),
      );

      final carId = ref.read(selectedCarIdProvider)!;
      await ref.read(parkingApiProvider).createParkingLocation({
        'car': toIri('cars', carId),
        'latitude': position.latitude,
        'longitude': position.longitude,
      });

      ref.invalidate(parkingLocationsProvider(carId));

      final currentLatLng = LatLng(position.latitude, position.longitude);
      _mapController.move(currentLatLng, 15);
      _prefetchTilesAround(currentLatLng);

      if (mounted) {
        await showAppMessageDialog(
          context,
          message: l10n.parkingSaved,
          type: AppMessageType.success,
        );
      }
    } catch (e) {
      if (mounted) {
        await showAppMessageDialog(
          context,
          message: e.toString(),
          type: AppMessageType.error,
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final carId = ref.watch(selectedCarIdProvider);
    final l10n = AppLocalizations.of(context)!;

    if (carId == null) return Center(child: Text(l10n.noCarSelected));

    final parkingAsync = ref.watch(parkingLocationsProvider(carId));

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(icon: Icons.local_parking_outlined, title: l10n.parkingTitle),
          Expanded(
            child: AsyncValueWidget(
              value: parkingAsync,
              data: (collection) {
                final last = collection.members.isNotEmpty ? collection.members.first : null;
                final markers = last == null
                    ? <Marker>[]
                    : [
                        Marker(
                          point: LatLng(last.latitude, last.longitude),
                          width: 40,
                          height: 40,
                          child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                        ),
                      ];

                final center = last != null
                    ? LatLng(last.latitude, last.longitude)
                    : const LatLng(51.5, 10.0);

                if (last != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _prefetchTilesAround(center);
                  });
                }

                return FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(initialCenter: center, initialZoom: 15),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.carcoop.app',
                      tileProvider: _CachedTileProvider(),
                    ),
                    MarkerLayer(markers: markers),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                parkingAsync.whenData((c) => c.members.isNotEmpty ? c.members.first : null).value != null
                    ? OutlinedButton.icon(
                        onPressed: () {
                          final loc = parkingAsync.value!.members.first;
                          _navigateTo(loc.latitude, loc.longitude);
                        },
                        icon: const Icon(Icons.directions_walk),
                        label: Text(l10n.navigateToVehicle),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _saving ? null : _setCurrentLocation,
                  icon: _saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.my_location),
                  label: Text(l10n.setParking),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
