/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class Assets {
  Assets._();

  static const AssetGenImage arrowLeftIcon =
      AssetGenImage('assets/ArrowLeftIcon.png');
  static const AssetGenImage accountCircle =
      AssetGenImage('assets/account_circle.png');
  static const AssetGenImage addAPhoto =
      AssetGenImage('assets/add_a_photo.png');
  static const AssetGenImage bagDarkIcon =
      AssetGenImage('assets/bagDarkIcon.png');
  static const AssetGenImage bagIcon = AssetGenImage('assets/bagIcon.png');
  static const AssetGenImage blankProfile =
      AssetGenImage('assets/blankProfile.png');
  static const AssetGenImage boyIcon = AssetGenImage('assets/boyIcon.png');
  static const AssetGenImage contoh = AssetGenImage('assets/contoh.png');
  static const AssetGenImage contractEditIcon =
      AssetGenImage('assets/contract_editIcon.png');
  static const AssetGenImage homeDarkIcon =
      AssetGenImage('assets/homeDarkIcon.png');
  static const AssetGenImage homeIcon = AssetGenImage('assets/homeIcon.png');
  static const AssetGenImage inventoryIcon =
      AssetGenImage('assets/inventoryIcon.png');
  static const AssetGenImage libraryBooks =
      AssetGenImage('assets/library_books.png');
  static const AssetGenImage logoApp = AssetGenImage('assets/logo_app.png');
  static const AssetGenImage logout = AssetGenImage('assets/logout.png');
  static const AssetGenImage menuIcon = AssetGenImage('assets/menuIcon.png');
  static const AssetGenImage noImage = AssetGenImage('assets/noImage.png');
  static const AssetGenImage receiptLongIcon =
      AssetGenImage('assets/receipt_longIcon.png');
  static const AssetGenImage signOutIcon =
      AssetGenImage('assets/signOutIcon.png');
  static const AssetGenImage splashImage =
      AssetGenImage('assets/splash_image.png');
  static const AssetGenImage trashIcon = AssetGenImage('assets/trashIcon.png');
  static const AssetGenImage userDarkIcon =
      AssetGenImage('assets/userDarkIcon.png');
  static const AssetGenImage userIcon = AssetGenImage('assets/userIcon.png');
  static const AssetGenImage widgetDarkIcon =
      AssetGenImage('assets/widgetDarkIcon.png');
  static const AssetGenImage widgetIcon =
      AssetGenImage('assets/widgetIcon.png');
  static const AssetGenImage widgets = AssetGenImage('assets/widgets.png');

  /// List of all assets
  static List<AssetGenImage> get values => [
        arrowLeftIcon,
        accountCircle,
        addAPhoto,
        bagDarkIcon,
        bagIcon,
        blankProfile,
        boyIcon,
        contoh,
        contractEditIcon,
        homeDarkIcon,
        homeIcon,
        inventoryIcon,
        libraryBooks,
        logoApp,
        logout,
        menuIcon,
        noImage,
        receiptLongIcon,
        signOutIcon,
        splashImage,
        trashIcon,
        userDarkIcon,
        userIcon,
        widgetDarkIcon,
        widgetIcon,
        widgets
      ];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
