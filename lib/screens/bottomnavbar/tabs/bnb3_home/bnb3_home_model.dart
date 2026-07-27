// ignore_for_file: unnecessary_getters_setters

import 'package:constructo/networking/extensions/api_helper.dart';

class HomeMaterialModel {
  String _category = "";
  String _name = "";
  String _detail = "";
  String _image = "";

  HomeMaterialModel();

  HomeMaterialModel.fromMap(Map data) {
    _category = apiPeramString(data['category']);
    _name = apiPeramString(data['name']);
    _detail = apiPeramString(data['detail']);
    _image = apiPeramString(data['image']);
  }

  String get category => _category;
  String get name => _name;
  String get detail => _detail;
  String get image => _image;

  set category(String value) => _category = value;
  set name(String value) => _name = value;
  set detail(String value) => _detail = value;
  set image(String value) => _image = value;
}

class HomeWorkerModel {
  String _name = "";
  String _trade = "";
  String _image = "";
  double _rating = 0;

  HomeWorkerModel();

  HomeWorkerModel.fromMap(Map data) {
    _name = apiPeramString(data['name']);
    _trade = apiPeramString(data['trade']);
    _image = apiPeramString(data['image']);
    _rating = apiPeramDouble(data['rating']);
  }

  String get name => _name;
  String get trade => _trade;
  String get image => _image;
  double get rating => _rating;

  set name(String value) => _name = value;
  set trade(String value) => _trade = value;
  set image(String value) => _image = value;
  set rating(double value) => _rating = value;
}

class HomeCategoryModel {
  String _name = "";
  String _image = "";

  HomeCategoryModel();

  HomeCategoryModel.fromMap(Map data) {
    _name = apiPeramString(data['name']);
    _image = apiPeramString(data['image']);
  }

  String get name => _name;
  String get image => _image;

  set name(String value) => _name = value;
  set image(String value) => _image = value;
}
