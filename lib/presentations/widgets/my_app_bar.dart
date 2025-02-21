import 'package:fit_lovers/presentations/cubit/settings/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.showSignOut = true});
  final String title;
// TODO: dodaj opciju za log out / dugme i funkc u cubit
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
                value: Locale('en'),
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: Locale('sr'),
                child: Text('Srpski'),
              ),
            ],
            onChanged: (Locale? locale) {
              if (locale != null) {
                context.read<LanguageCubit>().changeLanguage(locale);
              }
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
