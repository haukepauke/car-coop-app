import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../../../l10n/app_localizations.dart';

class OdometerCameraScreen extends StatefulWidget {
  const OdometerCameraScreen({super.key});

  @override
  State<OdometerCameraScreen> createState() => _OdometerCameraScreenState();
}

class _OdometerCameraScreenState extends State<OdometerCameraScreen> {
  static const double _frameWidthFactor = 0.92;
  static const double _frameHeightFactor = 0.28;

  CameraController? _controller;
  bool _initializing = true;
  bool _capturing = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _initializing = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _initializing = false;
      });
    }
  }

  Future<void> _capture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized || _capturing) return;

    setState(() => _capturing = true);
    try {
      final file = await controller.takePicture();
      final croppedPath = await _cropToGuide(file.path);
      if (!mounted) return;
      Navigator.of(context).pop(croppedPath);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  Future<String> _cropToGuide(String imagePath) async {
    final bytes = await File(imagePath).readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw StateError('Could not decode captured image');
    }

    final oriented = img.bakeOrientation(decoded);
    final cropWidth = (oriented.width * _frameWidthFactor).round();
    final cropHeight = (oriented.height * _frameHeightFactor).round();
    final x = ((oriented.width - cropWidth) / 2).round().clamp(0, oriented.width - 1);
    final y = ((oriented.height - cropHeight) / 2).round().clamp(0, oriented.height - 1);
    final safeWidth = cropWidth.clamp(1, oriented.width - x);
    final safeHeight = cropHeight.clamp(1, oriented.height - y);

    final cropped = img.copyCrop(
      oriented,
      x: x,
      y: y,
      width: safeWidth,
      height: safeHeight,
    );

    // Tesseract performs much better on a high-contrast monochrome strip
    // than on a raw camera crop.
    final enlarged = img.copyResize(
      cropped,
      width: cropped.width * 2,
      interpolation: img.Interpolation.linear,
    );
    final grayscale = img.grayscale(enlarged);
    final processed = img.luminanceThreshold(
      grayscale,
      threshold: 0.58,
    );

    final tempDir = await getTemporaryDirectory();
    final output = File(
      '${tempDir.path}/odometer_crop_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await output.writeAsBytes(img.encodeJpg(processed, quality: 95));
    return output.path;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(l10n.scanMileage),
      ),
      body: _buildBody(context, l10n),
    );
  }

  Widget _buildBody(BuildContext context, AppLocalizations l10n) {
    if (_initializing) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 48),
              const SizedBox(height: 16),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    final controller = _controller!;
    return Column(
      children: [
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CameraPreview(controller),
                  const _OdometerGuideOverlay(
                    frameWidthFactor: _frameWidthFactor,
                    frameHeightFactor: _frameHeightFactor,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            children: [
              Text(
                l10n.scanMileageAlignHint,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _capturing ? null : _capture,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(72, 72),
                  shape: const CircleBorder(),
                ),
                child: _capturing
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.camera_alt_outlined, size: 28),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OdometerGuideOverlay extends StatelessWidget {
  const _OdometerGuideOverlay({
    required this.frameWidthFactor,
    required this.frameHeightFactor,
  });

  final double frameWidthFactor;
  final double frameHeightFactor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth * frameWidthFactor;
        final height = constraints.maxHeight * frameHeightFactor;

        return Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withAlpha(110),
                BlendMode.srcOut,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: width,
                      height: height,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
