import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? automaticallyImply;
  final bool? centerTitle;
  final Color? backgroundColor;
  final bool? closable;

  const Navbar(
      {super.key,
      required this.title,
      this.leading,
      this.actions,
      this.automaticallyImply,
      this.centerTitle,
      this.backgroundColor,
      this.closable = false});

  @override
  Widget build(BuildContext context) {
    List<Widget> appBarActions = [...?actions];
    if (closable == true) {
      appBarActions.add(
        IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }

    return AppBar(
      automaticallyImplyLeading: automaticallyImply ?? false,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: centerTitle ?? true,
      backgroundColor: backgroundColor ?? Colors.white,
      actions: appBarActions,
      leading: leading,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
