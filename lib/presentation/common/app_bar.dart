
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget  {
  final String title;
  const AppBarWidget( this.title, {super.key} );

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
      );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}