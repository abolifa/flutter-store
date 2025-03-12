import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? automaticallyImply;
  final bool? centerTitle;
  final Color? backgroundColor;
  final bool? closable;
  final Widget? bottom;
  final String? backgroundImage;

  const Navbar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.automaticallyImply,
    this.centerTitle,
    this.backgroundColor,
    this.bottom,
    this.closable = false,
    this.backgroundImage,
  });

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
      title: title,
      centerTitle: centerTitle ?? true,
      backgroundColor: backgroundColor ?? Colors.white,
      // Make the background transparent to see the image
      actions: appBarActions,
      leading: leading,
      elevation: 0,
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight + 40),
              child: bottom!,
            )
          : null,
      flexibleSpace: backgroundImage != null
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImage!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : null, // Add the background image here
    );
  }

  @override
  Size get preferredSize {
    if (bottom != null) {
      return Size.fromHeight(kToolbarHeight + 40);
    }
    return const Size.fromHeight(kToolbarHeight);
  }
}
