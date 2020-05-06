import 'dart:async';

import 'package:flutter/material.dart';
import '../base/base_service.dart';
import '../models/dialog_models.dart';

class DialogService extends BaseService {
  GlobalKey<NavigatorState> _dialogNavigationKey = GlobalKey<NavigatorState>();

  Function(DialogRequest) _showDialogListener;

  Completer<DialogResponse> _dialogCompleter;

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  /// Registers a callback function. Typically to show the dialog
  void registerDialogListener(
    Function(DialogRequest) showDialogListener,
  ) {
    log.d('Registering Dialog Listener');
    _showDialogListener = showDialogListener;
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<DialogResponse> showDialog({
    String title,
    String description,
    String buttonTitle = 'Ok',
  }) {
    log.i('Showing Information Dialog');
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(
      DialogRequest(
        title: title,
        description: description,
        buttonTitle: buttonTitle,
      ),
    );
    return _dialogCompleter.future;
  }

  /// Shows a confirmation dialog
  Future<DialogResponse> showConfirmationDialog({
    String title,
    String description,
    String confirmationTitle = 'Ok',
    String cancelTitle = 'Cancel',
  }) {
    log.i('Showing Confirmation Dialog');
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(
      DialogRequest(
        title: title,
        description: description,
        buttonTitle: confirmationTitle,
        cancelTitle: cancelTitle,
      ),
    );
    return _dialogCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState.pop();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}