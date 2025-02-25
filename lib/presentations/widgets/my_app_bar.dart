import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/data/repositories/authentication_repository.dart';
import 'package:fit_lovers/presentations/cubit/settings/language/language_cubit.dart';
import 'package:fit_lovers/presentations/cubit/settings/language/language_state.dart';
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
      child: BlocConsumer<LogOutCubit, LogOutState>(
        builder: (context, state) {
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
                  // TODO: I clicked "Skip" button on [WelcomeView], and LogOut button is visible,
                  // TODO: By clicking this button Logout logic is triggered, even though I am not logged in. Fix.
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
                // done: Value declared here is not good, if we have LanguageCubit to handle languages for us, refactor.
                // : When working with dropdown buttons, try to keep the value of the items to be simple object
                // Simple objects are : String, int, bool etc.
                // Locale is not a simple object. It's a custom object
                // : The dropdown menu items should hold String values, and then parse them further to locales.
                // : If we hardcode the list of all supported locales like this, and have this logic in couple of places, we can forget
                //  one when adding new languages, all the available language values for a project should come from single source of truth.

                BlocBuilder<LanguageCubit, LanguageState>(
                  builder: (context, state) {
                    String currentLanguageCode = 'en';
                    if (state is LanguageChanged) {
                      currentLanguageCode = state.locale.languageCode;
                    }

                    return DropdownButton(
                      value: currentLanguageCode,
                      items: context
                          .read<LanguageCubit>()
                          .availableLanguages
                          .map((language) {
                        return DropdownMenuItem(
                          value: language['code']!,
                          child: Text(language['name']!),
                        );
                      }).toList(),
                      onChanged: (String? languageCode) {
                        if (languageCode != null) {
                          context
                              .read<LanguageCubit>()
                              .changeLanguage(languageCode);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: IconThemeData(color: Colors.black),
          );
        },
        listener: (context, state) {
          if (state is LogOutErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)!.invalidLogOut)));
            return;
          }
        },
      ),
    );
  }

  @override
  get preferredSize => Size.fromHeight(kToolbarHeight);
}
