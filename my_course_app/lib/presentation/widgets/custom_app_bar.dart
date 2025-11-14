import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1565C0),
      elevation: 0,
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}