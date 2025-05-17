import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final double? elevation;
  final Color? backgroundColor;

  const CustomAppBar({
    required this.title,
    this.showBack = false,
    this.onBack,
    this.actions,
    this.titleWidget,
    this.elevation,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    return AppBar(
      centerTitle: true,
      title: titleWidget ?? Text(title),
      elevation: elevation,
      backgroundColor: backgroundColor,
      actions: actions,
      leading:
          (showBack || canPop)
              ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBack ?? () => Navigator.of(context).maybePop(),
              )
              : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
