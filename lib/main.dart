import 'package:flutter/material.dart';
import 'package:ecodrive/core/constants/route_names.dart' as routes;
import 'package:ecodrive/core/router.dart' as router;
import 'package:ecodrive/core/services/navigator_service.dart';
import 'core/locator.dart';
import 'core/managers/dialog_manager.dart';
import 'core/services/dialog_service.dart';

void main() async {
  await LocatorInjector.setupLocator();
  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: locator<NavigatorService>().navigatorKey,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(child: child),
        ),
      ),
      theme: ThemeData(
        primaryColorDark: Color(0x00796B),
        primaryColorLight: Color(0xB2DFDB),
        primaryColor: Color(0x009688),
        iconTheme: IconThemeData(color: Color(0xFFFFFF)),
        accentColor: Color(0x4CAF50),
        dividerColor: Color(0xBDBDBD),
      ),
      initialRoute: routes.HomeViewRoute,
      onGenerateRoute: router.generateRoute,
    );
  }
}
