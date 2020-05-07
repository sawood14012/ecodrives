import 'package:flutter_template/core/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final String _title = "Home";
  final String _body = "Home View";

  String get title => this._title;
  String get body => this._body;
}
