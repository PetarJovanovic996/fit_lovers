import 'package:fit_lovers/data/models/language.dart';
import 'package:fit_lovers/data/repositories/authentication_repository.dart';
import 'package:fit_lovers/presentations/cubit/settings/language/language_cubit.dart';
import 'package:fit_lovers/presentations/cubit/settings/language/language_state.dart';
import 'package:fit_lovers/presentations/cubit/settings/user_settings/log_out/log_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.showSignOut = true});
  final String title;
  final bool showSignOut;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
          const Spacer(
            flex: 8,
          ),
          const LogoutButton(),
          const Spacer(),
          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              String currentLanguageCode = state.locale.languageCode;

              return DropdownButton(
                value: currentLanguageCode,
                items: Language.availableLanguages.map((language) {
                  return DropdownMenuItem(
                    value: language['code']!,
                    child: Text(language['name']!),
                  );
                }).toList(),
                onChanged: (String? languageCode) {
                  if (languageCode != null) {
                    context.read<LanguageCubit>().changeLanguage(languageCode);
                  }
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  @override
  get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class LogoutButton extends StatelessWidget {
  @visibleForTesting
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<AuthenticationRepository>().user,
      builder: (context, snapshot) {
        bool isLoggedIn =
            snapshot.hasData ? snapshot.data != User.empty : false;

        if (!isLoggedIn) {
          return const SizedBox.shrink();
        }

        return IconButton(
          onPressed: () => context.read<LogOutCubit>().logOut(),
          icon: const Icon(Icons.logout),
        );
      },
    );
  }
}
