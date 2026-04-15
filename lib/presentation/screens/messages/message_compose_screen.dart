import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/api/message_api.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/car_provider.dart';
import '../../../providers/message_provider.dart';
import '../../widgets/common/app_message_dialog.dart';

class MessageComposeScreen extends ConsumerStatefulWidget {
  const MessageComposeScreen({super.key});

  @override
  ConsumerState<MessageComposeScreen> createState() =>
      _MessageComposeScreenState();
}

class _MessageComposeScreenState extends ConsumerState<MessageComposeScreen> {
  final _contentController = TextEditingController();
  final List<XFile> _photos = [];
  bool _loading = false;

  Future<void> _pickPhoto() async {
    final l10n = AppLocalizations.of(context)!;
    if (_photos.length >= 4) {
      await showAppMessageDialog(
        context,
        message: l10n.messageMaxPhotos,
        type: AppMessageType.warning,
      );
      return;
    }
    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (photo != null) setState(() => _photos.add(photo));
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    if (_contentController.text.trim().isEmpty) {
      await showAppMessageDialog(
        context,
        message: l10n.messageContentRequired,
        type: AppMessageType.warning,
      );
      return;
    }
    setState(() => _loading = true);
    try {
      final carId = ref.read(selectedCarIdProvider)!;
      await ref.read(messageApiProvider).createMessage(
            carId: carId,
            content: _contentController.text.trim(),
            photoPaths: _photos.map((f) => f.path).toList(),
          );
      ref.invalidate(messagesProvider(carId));
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        await showAppMessageDialog(
          context,
          message: e.toString(),
          type: AppMessageType.error,
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.newMessage),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: l10n.messageWriteHint,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (_photos.isNotEmpty)
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _photos.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) => Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_photos[index].path),
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => setState(() => _photos.removeAt(index)),
                          child: const CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.close, size: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _photos.length < 4 ? _pickPhoto : null,
              icon: const Icon(Icons.photo_library_outlined),
              label: Text(l10n.messageAddPhotoCount(_photos.length)),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const CircularProgressIndicator(strokeWidth: 2)
                  : Text(l10n.messagePost),
            ),
          ],
        ),
      ),
    );
  }
}
