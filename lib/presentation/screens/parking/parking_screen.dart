import 'package:flutter/material.dart';
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
import '../../widgets/common/page_header.dart';

class ParkingScreen extends ConsumerStatefulWidget {
  const ParkingScreen({super.key});

  @override
  ConsumerState<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends ConsumerState<ParkingScreen> {
  final _mapController = MapController();
  bool _saving = false;

  Future<void> _navigateTo(double lat, double lng) async {
    final l10n = AppLocalizations.of(context)!;
    final uri = Uri.parse('geo:$lat,$lng?q=$lat,$lng');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.couldNotOpenNav)),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.locationPermissionRequired)),
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

      _mapController.move(LatLng(position.latitude, position.longitude), 15);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.parkingSaved)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
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

                return FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(initialCenter: center, initialZoom: 15),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.carcoop.app',
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
