import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/data/repositories/authentication_repository.dart';
import 'package:fit_lovers/presentations/cubit/settings/language/language_cubit.dart';
import 'package:fit_lovers/presentations/cubit/settings/user_settings/log_out/log_out_cubit.dart';
import 'package:fit_lovers/presentations/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.showSignOut = true});
  final String title;
// done: dodaj opciju za log out / dugme i funkc u cubit
  final bool showSignOut;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogOutCubit(AuthenticationRepository()),
      child: BlocConsumer<LogOutCubit, LogOutState>(builder: (context, state) {
        if (state is LogOutLoading) {
          return LoadingWidget();
        }

        return AppBar(
          title: Row(
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
              // done: This is not good, google [Spacer] widget
              Spacer(
                flex: 8,
              ),
              if (showSignOut)
                IconButton(
                    onPressed: () {
                      context.read<LogOutCubit>().logOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.welcomeViewScreen,
                        (Route<dynamic> route) => false,
                      );
                    },
                    icon: Icon(Icons.logout)),
              Spacer(),
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
      }, listener: (context, state) {
        if (state is LogOutErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.invalidLogOut)));
          return;
        }
      }),
    );
  }

  @override
  get preferredSize => Size.fromHeight(kToolbarHeight);
}
