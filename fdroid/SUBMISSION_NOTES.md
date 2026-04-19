# F-Droid Submission Notes

This directory contains a draft `fdroiddata` metadata file for the Android app:

- package id: `net.carcoop.app`
- app repo: `https://github.com/haukepauke/car-coop-app`
- backend repo: `https://github.com/haukepauke/car-coop`

Build facts used for the draft:

- app version: `1.0.1`
- version code: `3`
- git tag: `1.0.1`
- verified local release command: `./android/gradlew assembleRelease`
- verified local output: `build/app/outputs/flutter-apk/app-release.apk`

Backend and network model:

- the Android app connects to a user-configurable Car Coop server
- the backend is intended to be self-hosted
- the server source code is published in the `car-coop` repository
- no centralized proprietary service is required by the app itself

Permissions to explain if reviewers ask:

- `CAMERA` and `READ_MEDIA_IMAGES` are used for odometer photo capture
- `ACCESS_FINE_LOCATION` and `ACCESS_COARSE_LOCATION` are used for saving the parking position and navigating back to the vehicle
- `INTERNET` is required for talking to the configured Car Coop server
