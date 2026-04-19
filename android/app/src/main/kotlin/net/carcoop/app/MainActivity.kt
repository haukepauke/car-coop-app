package net.carcoop.app

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationManager
import android.os.CancellationSignal
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.location.LocationManagerCompat
import androidx.core.util.Consumer
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private var permissionResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "net.carcoop.app/location",
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "checkPermission" -> result.success(hasLocationPermission())
                "requestPermission" -> handleRequestPermission(result)
                "getCurrentPosition" -> handleGetCurrentPosition(result)
                else -> result.notImplemented()
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        if (requestCode == LOCATION_PERMISSION_REQUEST_CODE && permissionResult != null) {
            val granted = grantResults.any { it == PackageManager.PERMISSION_GRANTED }
            permissionResult?.success(granted)
            permissionResult = null
            return
        }

        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }

    private fun handleRequestPermission(result: MethodChannel.Result) {
        if (hasLocationPermission()) {
            result.success(true)
            return
        }
        if (permissionResult != null) {
            result.error("IN_PROGRESS", "Another permission request is already active.", null)
            return
        }

        permissionResult = result
        ActivityCompat.requestPermissions(
            this,
            arrayOf(
                Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION,
            ),
            LOCATION_PERMISSION_REQUEST_CODE,
        )
    }

    private fun handleGetCurrentPosition(result: MethodChannel.Result) {
        if (!hasLocationPermission()) {
            result.error("PERMISSION_DENIED", "Location permission is required.", null)
            return
        }

        val locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager
        val provider = getEnabledProviders(locationManager).firstOrNull()

        if (provider == null) {
            result.error("LOCATION_DISABLED", "Location services are disabled.", null)
            return
        }

        try {
            val cancellationSignal = CancellationSignal()
            val consumer = Consumer<Location?> { location ->
                val resolvedLocation = location ?: getLastKnownLocation(locationManager)
                if (resolvedLocation == null) {
                    result.error(
                        "LOCATION_UNAVAILABLE",
                        "Current location is unavailable.",
                        null,
                    )
                    return@Consumer
                }

                result.success(
                    mapOf(
                        "latitude" to resolvedLocation.latitude,
                        "longitude" to resolvedLocation.longitude,
                    ),
                )
            }

            LocationManagerCompat.getCurrentLocation(
                locationManager,
                provider,
                cancellationSignal,
                ContextCompat.getMainExecutor(this),
                consumer,
            )
        } catch (error: SecurityException) {
            result.error("PERMISSION_DENIED", "Location permission is required.", null)
        }
    }

    private fun hasLocationPermission(): Boolean {
        return ActivityCompat.checkSelfPermission(
            this,
            Manifest.permission.ACCESS_FINE_LOCATION,
        ) == PackageManager.PERMISSION_GRANTED ||
            ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_COARSE_LOCATION,
            ) == PackageManager.PERMISSION_GRANTED
    }

    private fun getEnabledProviders(locationManager: LocationManager): List<String> {
        return listOf(
            LocationManager.GPS_PROVIDER,
            LocationManager.NETWORK_PROVIDER,
            LocationManager.PASSIVE_PROVIDER,
        ).filter(locationManager::isProviderEnabled)
    }

    private fun getLastKnownLocation(locationManager: LocationManager): Location? {
        return getEnabledProviders(locationManager)
            .mapNotNull(locationManager::getLastKnownLocation)
            .maxByOrNull(Location::getTime)
    }

    companion object {
        private const val LOCATION_PERMISSION_REQUEST_CODE = 1001
    }
}
