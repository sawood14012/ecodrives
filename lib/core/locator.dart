import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'logger.dart';
import 'services/dialog_service.dart';
import 'services/navigator_service.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  static Logger _log = getLogger('LocatorInjector');
  static Future<void> setupLocator() async {
    _log.d('Initializing Navigator Service');
    locator.registerLazySingleton(
      () => NavigatorService(),
    );
    _log.d('Initializing Dialog Service');
    locator.registerLazySingleton(
      () => DialogService(),
    );
  }
}