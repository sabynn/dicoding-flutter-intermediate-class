import 'dart:io';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app3/provider/database_provider.dart';
import 'package:restaurant_app3/provider/preferences_provider.dart';
import 'package:restaurant_app3/provider/restaurants_provider.dart';
import 'package:restaurant_app3/provider/scheduling_provider.dart';
import 'package:restaurant_app3/utils/background_service.dart';
import 'package:restaurant_app3/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/navigation.dart';
import 'data/api/api_service.dart';
import 'data/db/database_helper.dart';
import 'data/preferences/preferences_helper.dart';
import 'ui/splash_screen.dart';
import 'data/model/restaurant.dart';
import 'ui/detail_page.dart';
import 'ui/list_page.dart';
import 'package:flutter/material.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) await AndroidAlarmManager.initialize();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantsProvider>(
          create: (_) => RestaurantsProvider(
              apiService: ApiService(), restaurant: null, type: 'list'),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
            create: (_) => SchedulingProvider()),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            title: 'Restaurant',
            theme: provider.themeData,
            initialRoute: RestaurantSplashScreen.routeName,
            routes: {
              RestaurantSplashScreen.routeName: (context) =>
                  const RestaurantSplashScreen(),
              RestaurantsListPage.routeName: (context) => const RestaurantsListPage(),
              RestaurantDetails.routeName: (context) => RestaurantDetails(
                    restaurant: ModalRoute.of(context)?.settings.arguments
                        as Restaurant,
                  ),
            },
          );
        },
      ),
    );
  }
}
