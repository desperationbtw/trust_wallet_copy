import 'package:flutter/material.dart';
import 'package:trust_wallet_scm/uikit/uikit.dart';

class UITextStyle {
  static const fontFamily = 'Roboto';

  static TextStyle custom(
    UIThemeData theme, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
  }) =>
      TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: height ?? 1.5,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.text800,
      );

  static TextStyle valueHeader(UIThemeData theme, {Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: 1.5,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.text800,
      );

  static TextStyle header(UIThemeData theme, {Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: 1.5,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.text800,
      );

  static TextStyle title(UIThemeData theme, {Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: 1.5,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.text800,
      );

  static TextStyle titleMed(UIThemeData theme, {Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: 1.5,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.text800,
      );

  static TextStyle subTitle(UIThemeData theme, {Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.w500,
        height: 1.5,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.text800,
      );

  static TextStyle caption(UIThemeData theme, {Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: 1.58,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.text800,
      );

  static TextStyle badge(UIThemeData theme, {Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 10,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: 1.58,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.ui300,
      );

  static TextStyle navigation(UIThemeData theme, {Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: fontWeight ?? FontWeight.w500,
        height: 1.58,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.navigationBarSelectedForeground,
      );

  static TextStyle iconButton(UIThemeData theme, {Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: fontWeight ?? FontWeight.w500,
        height: 1.58,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.text800,
      );

  static TextStyle buttonFab(UIThemeData theme, {Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w500,
        height: 1.5,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.text800,
      );

  static TextStyle buttonText(UIThemeData theme, {Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.w500,
        height: 1.5,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.text800,
      );

  static TextStyle button(UIThemeData theme, {Color? color, FontWeight? fontWeight}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: 1.71,
        letterSpacing: 0.5,
        leadingDistribution: TextLeadingDistribution.even,
        color: color ?? theme.text800,
      );
}
