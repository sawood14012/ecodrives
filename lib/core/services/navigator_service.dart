import 'package:flutter/material.dart';
import 'package:ecodrive/core/base/base_service.dart';

class NavigatorService extends BaseService {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  bool pop() {
    return _navigatorKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigatorKey.currentState.pushNamed(
      routeName,
      arguments: arguments,
    );
  }
}
