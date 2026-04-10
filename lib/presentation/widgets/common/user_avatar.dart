import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/models/user_ref.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
    this.radius = 20,
    this.apiUrl,
  });

  final UserRef user;
  final double radius;
  final String? apiUrl;

  @override
  Widget build(BuildContext context) {
    final color = _parseColor(user.color) ?? Theme.of(context).colorScheme.primary;
    final photoPath = user.profilePicturePath;
    final photoUrl = (apiUrl != null && photoPath != null && photoPath.isNotEmpty)
        ? '$apiUrl/uploads/users/$photoPath'
        : null;

    if (photoUrl != null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: color,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: photoUrl,
            width: radius * 2,
            height: radius * 2,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => _initials(context, color),
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: _initials(context, color),
    );
  }

  Widget _initials(BuildContext context, Color bgColor) {
    final parts = user.name.trim().split(' ');
    final text = parts.length >= 2
        ? '${parts.first[0]}${parts.last[0]}'.toUpperCase()
        : user.name.isNotEmpty
            ? user.name[0].toUpperCase()
            : '?';
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: radius * 0.7,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Color? _parseColor(String? hex) {
    if (hex == null) return null;
    final sanitized = hex.replaceAll('#', '');
    if (sanitized.length == 6) {
      return Color(int.parse('FF$sanitized', radix: 16));
    }
    return null;
  }
}
