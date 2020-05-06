import 'package:flutter/material.dart';
import 'package:flutter_template/core/constants/route_names.dart' as routes;
import 'package:flutter_template/core/router.dart' as router;
import 'package:flutter_template/core/services/navigator_service.dart';
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
        primarySwatch: Colors.blue,
      ),
      initialRoute: routes.HomeViewRoute,
      onGenerateRoute: router.generateRoute,
    );
  }
}
