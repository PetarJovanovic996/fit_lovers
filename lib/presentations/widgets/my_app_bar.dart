import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/domain/cubit/authentication/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_lovers/domain/cubit/settings/language_cubit.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title, this.showSignOut = false});

  final String title;
  final bool showSignOut;

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
          DropdownButton(
            value: Localizations.localeOf(context),
            items: [
              DropdownMenuItem(
                value: Locale('en', 'US'),
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: Locale('sr', 'RS'),
                child: Text('Srpski'),
              ),
            ],
            onChanged: (Locale? locale) {
              if (locale != null) {
                context.read<LanguageCubit>().changeLanguage(locale);
              }
            },
          ),
          if (showSignOut)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthCubit>().signOut();
                Navigator.of(context).pushReplacementNamed(Routes.logInScreen);
              },
            ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
