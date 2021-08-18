import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app3/provider/preferences_provider.dart';
import 'package:restaurant_app3/provider/scheduling_provider.dart';
import 'package:restaurant_app3/widgets/custom_scaffold.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      theTitle: "Settings",
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Material(
                    child: ListTile(
                      title: const Text('Dark Theme'),
                      trailing: Switch.adaptive(
                        value: provider.isDarkTheme,
                        onChanged: (value) {
                          provider.enableDarkTheme(value);
                        },
                      ),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      title: const Text('Restaurant Notification'),
                      trailing: Consumer<SchedulingProvider>(
                        builder: (context, scheduled, _) {
                          return Switch.adaptive(
                            value: provider.isDailyNewsActive,
                            onChanged: (value) async {
                              scheduled.scheduledInfo(value);
                              provider.enableDailyNews(value);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
