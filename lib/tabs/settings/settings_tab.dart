import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/tabs/settings/language.dart';
import 'package:todo/tabs/settings/settings_provider.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  List<Language> languages = [
    Language(name: 'English', code: 'en'),
    Language(name: 'العربية', code: 'ar')
  ];
  bool isDarkTheme = false;
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.2,
          color: AppTheme.primary,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              top: 20,
              start: 12,
            ),
            child: SafeArea(
              child: Text(
                'To Do List',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppTheme.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Logout',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    onPressed: () {
                      FirebaseFunctions.logout();
                      Provider.of<UserProvider>(context, listen: false)
                          .updateUser(null);
                      Provider.of<TasksProvider>(context, listen: false)
                          .reset();
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Language',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: AppTheme.primary,
                    width: 1.5,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Language>(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    value: languages.firstWhere(
                      (language) =>
                          language.code == settingsProvider.languageCode,
                    ),
                    items: languages
                        .map(
                          (language) => DropdownMenuItem(
                            value: language,
                            child: Text(
                              language.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      settingsProvider.changeLanguage(value!.code);
                    },
                    iconEnabledColor: AppTheme.primary,
                    icon: Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 42,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Text(
                'Theme',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: AppTheme.primary,
                    width: 1.5,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Language>(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    value: languages.firstWhere(
                      (language) =>
                          language.code == settingsProvider.languageCode,
                    ),
                    items: languages
                        .map(
                          (language) => DropdownMenuItem(
                            value: language,
                            child: Text(
                              language.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      settingsProvider.changeLanguage(value!.code);
                    },
                    iconEnabledColor: AppTheme.primary,
                    icon: Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 42,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
