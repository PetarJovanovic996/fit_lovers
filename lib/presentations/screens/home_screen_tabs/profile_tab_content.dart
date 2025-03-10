import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/presentations/cubit/settings/cubit/theme_cubit.dart';
import 'package:fit_lovers/presentations/cubit/settings/language/language_cubit.dart';
import 'package:fit_lovers/presentations/cubit/settings/language/language_state.dart';
import 'package:fit_lovers/presentations/cubit/settings/user_settings/log_out/log_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileTabContent extends StatelessWidget {
  const ProfileTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          label: Text(
            AppLocalizations.of(context)!.editProfile,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.editProfileScreen);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(250, 60),
            maximumSize: const Size(250, 60),
          ),
          icon: const Icon(
            Icons.edit,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
          String currentLanguageCode = state.locale.languageCode;

          return ElevatedButton.icon(
            onPressed: () {
              String nextLanguageCode =
                  currentLanguageCode == 'en' ? 'sr' : 'en';
              context.read<LanguageCubit>().changeLanguage(nextLanguageCode);
            },
            label: Text(
              AppLocalizations.of(context)!.switchLanguage,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(250, 60),
              maximumSize: const Size(250, 60),
            ),
            icon: const Icon(
              Icons.language,
              color: Colors.black,
            ),
          );
        }),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton.icon(
          label: Text(
            AppLocalizations.of(context)!.switchTheme,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () {
            context.read<ThemeCubit>().toggleTheme();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(250, 60),
            maximumSize: const Size(250, 60),
          ),
          icon: const Icon(
            Icons.photo_size_select_actual,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton.icon(
          label: Text(
            AppLocalizations.of(context)!.logOut,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () {
            context.read<LogOutCubit>().logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.welcomeViewScreen,
              (Route<dynamic> route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(250, 60),
            maximumSize: const Size(250, 60),
          ),
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton.icon(
          label: Text(
            AppLocalizations.of(context)!.deleteAccount,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(250, 60),
            maximumSize: const Size(250, 60),
          ),
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    ));
  }
}
