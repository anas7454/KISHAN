import 'package:constructo/utils/theme/app_theme/build_material_color.dart';
import 'package:constructo/utils/theme/app_theme/color_scheme.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class AppThemes {
  // ---------------- LIGHT ----------------------------
  static ThemeData lightTheme(BuildContext context) => ThemeData(
    useMaterial3: true,
    fontFamily: 'Lufga',
    primarySwatch: buildMaterialColor(AppColors.secondry),
    colorScheme: lightColorScheme(context),
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.scafoldBg,
    primaryColor: AppColors.primary, // Aapka brand color
    cardColor: AppColors.cardBg,
    disabledColor: AppColors.disable,
    dividerColor: AppColors.border,
    hoverColor: AppColors.hoverColor,
    highlightColor: Colors.white.withValues(alpha: 0.06),
    splashColor: AppColors.splashColor,
    // focusColor: Colors.white.withValues(alpha: 0.1),
    focusColor: Colors.transparent, // border show krayenge isliye
    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSizes.horzontalSpace15,
      ), // ← removes horizontal padding
      dense: true,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.scafoldBg,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.iconColor),
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    // dialogTheme: DialogThemeData(
    //   shape: roundedRectangleBorderDefault(context),
    //   backgroundColor: AppColors.appUiColorsModel(context).lightThemeModel.cardBg,
    //   titleTextStyle: AppTextStyles.ts16w600colorTextPrimary(context),
    //   contentTextStyle: AppTextStyles.ts14w400colorTextSecondry(context),
    // ),
    // datePickerTheme: DatePickerThemeData(
    //   backgroundColor: AppColors.appUiColorsModel(context).lightThemeModel.cardBg,
    //   shape: roundedRectangleBorderDefault(context),
    //   headerBackgroundColor: AppColors.appUiColorsModel(context).lightThemeModel.primaryDark,
    //   headerForegroundColor: AppColors.appUiColorsModel(context).lightThemeModel.onprimary,
    //   todayBorder: borderSideDefault(context, color: AppColors.appUiColorsModel(context).lightThemeModel.primary),
    // ),
  );
}
