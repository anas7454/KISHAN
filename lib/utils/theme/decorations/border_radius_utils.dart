import 'package:constructo/utils/theme/sizes/app_sizes.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';

BorderRadius borderRadiusDefault([num? borderRadius]) {
  return BorderRadius.circular(
    borderRadius?.toDouble() ?? AppSizes.borderRadiusCard,
  );
}

BorderRadius borderRadius2() => BorderRadius.circular(2.rr);

BorderRadius borderRadius4() => BorderRadius.circular(4.rr);

BorderRadius borderRadius5() => BorderRadius.circular(5.rr);

BorderRadius borderRadius10() => BorderRadius.circular(10.rr);

BorderRadius borderRadius15() => BorderRadius.circular(15.rr);

BorderRadius borderRadius20() => BorderRadius.circular(20.rr);

BorderRadius borderRadiusCard([num? borderRadius]) {
  return BorderRadius.circular(
    borderRadius?.toDouble() ?? AppSizes.borderRadiusCard,
  );
}

BorderRadius borderRadiusCardOnlyTop({double? radius}) {
  return BorderRadius.only(
    topLeft: Radius.circular(radius ?? AppSizes.borderRadiusCard),
    topRight: Radius.circular(radius ?? AppSizes.borderRadiusCard),
  );
}

BorderRadius borderRadiusCardOnlyTop20({double? radius}) {
  return BorderRadius.only(
    topLeft: Radius.circular(radius ?? 20.rr),
    topRight: Radius.circular(radius ?? 20.rr),
  );
}

BorderRadius borderRadiusTLR({double? radius}) {
  return BorderRadius.only(
    topLeft: Radius.circular(radius ?? 30.rh),
    topRight: Radius.circular(radius ?? 30.rh),
    bottomLeft: Radius.circular(radius ?? 30.rh),
  );
}

BorderRadius borderRadiusCardOnlyBottom() {
  return BorderRadius.only(
    bottomLeft: Radius.circular(AppSizes.borderRadiusCard),
    bottomRight: Radius.circular(AppSizes.borderRadiusCard),
  );
}
