import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          Expanded(child: Container()),
          DropdownButton(items: [], onChanged: (_) {})
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
