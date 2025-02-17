import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_lovers/domain/cubit/settings/language_cubit.dart';

// TODO: MyAppBar is not clear naming?
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: Fix error when switching a language.
    // Error message being shown inside the console :
    // Warning: This application's locale, sr_RS, is not supported by all of its localization delegates.
    // Solution is very simple. Use google.
    return AppBar(
      title: Row(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          // TODO: This is not good, google [Spacer] widget
          // TODO: Why add additional widget if we have mainAxisAlignment property in the Row widget?
          Expanded(child: Container()),
          // TODO: Value declared here is not good, if we have LanguageCubit to handle languages for us, refactor.
          DropdownButton(
            value: Localizations.localeOf(context),
            items: [
              // TODO: When working with dropdown buttons, try to keep the value of the items to be simple object
              // Simple objects are : String, int, bool etc.
              // Locale is not a simple object. It's a custom object
              // TODO: The dropdown menu items should hold String values, and then parse them further to locales.
              // TODO: If we hardcode the list of all supported locales like this, and have this logic in couple of places, we can forget
              //  one when adding new languages, all the available language values for a project should come from single source of truth.

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
          )
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
