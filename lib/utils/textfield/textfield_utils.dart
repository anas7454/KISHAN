import 'package:constructo/utils/theme/sizes/container_const_funtions.dart';
import 'package:flutter/material.dart';

class TextfieldUtils {
  static BoxConstraints prefixIconConstraints35width() {
    // verified
    return BoxConstraints(
      minWidth: 35.rh, // default 48
      minHeight: 18.rh,
      maxWidth: 35.rh,
      maxHeight: 18.rh,
    );
  }

  static BoxConstraints prefixIconConstraints20width() {
    return BoxConstraints(
      minWidth: 30.rh,
      minHeight: 20.rh,
      maxWidth: 30.rh,
      maxHeight: 20.rh,
    );
  }

  // special
  static BoxConstraints prefixIconConstraints40width() {
    return BoxConstraints(
      minWidth: 40.rh, // default 48
      maxWidth: 40.rh,
    );
  }

  static BoxConstraints prefixIconConstraints46width() {
    return BoxConstraints(
      minWidth: 46.rh, // default 48
      maxWidth: 46.rh,
    );
  }

  static BoxConstraints prefixIconConstraints25width({double? width}) {
    return BoxConstraints(maxWidth: width ?? 25.rh);
  }
}

//  prefixIconConstraints: TextfieldUtils.prefixIconConstraints20width(),
