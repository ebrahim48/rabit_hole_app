import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileImage extends StatelessWidget {
  final String? imageUrl;

  const CustomProfileImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final bool isValidUrl = imageUrl != null &&
        imageUrl!.isNotEmpty &&
        (imageUrl!.startsWith('http://') || imageUrl!.startsWith('https://'));

    return Container(
      width: 60.w,
      height: 60.h,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: isValidUrl
            ? Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _placeholder();
          },
        )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade300,
      child: Icon(
        Icons.person,
        size: 40.w,
        color: Colors.grey.shade600,
      ),
    );
  }
}
