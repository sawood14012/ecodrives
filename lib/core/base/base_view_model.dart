import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../logger.dart';

class BaseViewModel extends ChangeNotifier {
  String _title;

  bool _busy;
  bool _isDisposed = false;

  Logger log;

  BaseViewModel({
    bool busy = false,
    String title,
  })  : _busy = busy,
        _title = title {
    log = getLogger(title ?? this.runtimeType.toString());
  }

  bool get busy => this._busy;
  set busy(bool busy) {
    log.d(
      'busy: '
      '$title is entering '
      '${busy ? 'busy' : 'free'} state',
    );
    this._busy = busy;
    notifyListeners();
  }

  bool get isDisposed => this._isDisposed;

  String get title => _title ?? this.runtimeType.toString();

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    } else {
      log.w(
        'notifyListeners: Notify listeners called after '
        '${title ?? this.runtimeType.toString()} has been disposed',
      );
    }
  }

  @override
  void dispose() {
    log.d('dispose');
    _isDisposed = true;
    super.dispose();
  }
}