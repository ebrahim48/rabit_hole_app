// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:lottie/lottie.dart' as _lottie;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/achievements.svg
  SvgGenImage get achievements =>
      const SvgGenImage('assets/icons/achievements.svg');

  /// File path: assets/icons/bigpacks.svg
  SvgGenImage get bigpacks => const SvgGenImage('assets/icons/bigpacks.svg');

  /// File path: assets/icons/camera.svg
  SvgGenImage get camera => const SvgGenImage('assets/icons/camera.svg');

  /// File path: assets/icons/carrotPacks.svg
  SvgGenImage get carrotPacks =>
      const SvgGenImage('assets/icons/carrotPacks.svg');

  /// File path: assets/icons/email.svg
  SvgGenImage get email => const SvgGenImage('assets/icons/email.svg');

  /// File path: assets/icons/firstfall.svg
  SvgGenImage get firstfall => const SvgGenImage('assets/icons/firstfall.svg');

  /// File path: assets/icons/gameplay.svg
  SvgGenImage get gameplay => const SvgGenImage('assets/icons/gameplay.svg');

  /// File path: assets/icons/gmail.svg
  SvgGenImage get gmail => const SvgGenImage('assets/icons/gmail.svg');

  /// File path: assets/icons/google.svg
  SvgGenImage get google => const SvgGenImage('assets/icons/google.svg');

  /// File path: assets/icons/highscores.svg
  SvgGenImage get highscores =>
      const SvgGenImage('assets/icons/highscores.svg');

  /// File path: assets/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/home.svg');

  /// File path: assets/icons/logout.svg
  SvgGenImage get logout => const SvgGenImage('assets/icons/logout.svg');

  /// File path: assets/icons/nameProfile.svg
  SvgGenImage get nameProfile =>
      const SvgGenImage('assets/icons/nameProfile.svg');

  /// File path: assets/icons/pass.svg
  SvgGenImage get pass => const SvgGenImage('assets/icons/pass.svg');

  /// File path: assets/icons/powerups.svg
  SvgGenImage get powerups => const SvgGenImage('assets/icons/powerups.svg');

  /// File path: assets/icons/profileedit.svg
  SvgGenImage get profileedit =>
      const SvgGenImage('assets/icons/profileedit.svg');

  /// File path: assets/icons/rabbit.svg
  SvgGenImage get rabbit => const SvgGenImage('assets/icons/rabbit.svg');

  /// File path: assets/icons/rabbitSkin.svg
  SvgGenImage get rabbitSkin =>
      const SvgGenImage('assets/icons/rabbitSkin.svg');

  /// File path: assets/icons/scoreicon.svg
  SvgGenImage get scoreicon => const SvgGenImage('assets/icons/scoreicon.svg');

  /// File path: assets/icons/scores.svg
  SvgGenImage get scores => const SvgGenImage('assets/icons/scores.svg');

  /// File path: assets/icons/settings.svg
  SvgGenImage get settings => const SvgGenImage('assets/icons/settings.svg');

  /// File path: assets/icons/shield.svg
  SvgGenImage get shield => const SvgGenImage('assets/icons/shield.svg');

  /// File path: assets/icons/shop.svg
  SvgGenImage get shop => const SvgGenImage('assets/icons/shop.svg');

  /// File path: assets/icons/start.svg
  SvgGenImage get start => const SvgGenImage('assets/icons/start.svg');

  /// File path: assets/icons/statistics.svg
  SvgGenImage get statistics =>
      const SvgGenImage('assets/icons/statistics.svg');

  /// File path: assets/icons/win.svg
  SvgGenImage get win => const SvgGenImage('assets/icons/win.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    achievements,
    bigpacks,
    camera,
    carrotPacks,
    email,
    firstfall,
    gameplay,
    gmail,
    google,
    highscores,
    home,
    logout,
    nameProfile,
    pass,
    powerups,
    profileedit,
    rabbit,
    rabbitSkin,
    scoreicon,
    scores,
    settings,
    shield,
    shop,
    start,
    statistics,
    win,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/carrot.png
  AssetGenImage get carrot => const AssetGenImage('assets/images/carrot.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/rabbit.png
  AssetGenImage get rabbit => const AssetGenImage('assets/images/rabbit.png');

  /// File path: assets/images/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/images/splash.png');

  /// List of all assets
  List<AssetGenImage> get values => [carrot, logo, rabbit, splash];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/buttonLoading.json
  LottieGenImage get buttonLoading =>
      const LottieGenImage('assets/lottie/buttonLoading.json');

  /// File path: assets/lottie/no_data.json
  LottieGenImage get noData =>
      const LottieGenImage('assets/lottie/no_data.json');

  /// File path: assets/lottie/no_internet.json
  LottieGenImage get noInternet =>
      const LottieGenImage('assets/lottie/no_internet.json');

  /// File path: assets/lottie/paymentfail.json
  LottieGenImage get paymentfail =>
      const LottieGenImage('assets/lottie/paymentfail.json');

  /// File path: assets/lottie/paymentsuccess.json
  LottieGenImage get paymentsuccess =>
      const LottieGenImage('assets/lottie/paymentsuccess.json');

  /// List of all assets
  List<LottieGenImage> get values => [
    buttonLoading,
    noData,
    noInternet,
    paymentfail,
    paymentsuccess,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName, {this.flavors = const {}});

  final String _assetName;
  final Set<String> flavors;

  _lottie.LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    _lottie.FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    _lottie.LottieDelegates? delegates,
    _lottie.LottieOptions? options,
    void Function(_lottie.LottieComposition)? onLoaded,
    _lottie.LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, _lottie.LottieComposition?)?
    frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
    _lottie.LottieDecoder? decoder,
    _lottie.RenderCache? renderCache,
    bool? backgroundLoading,
  }) {
    return _lottie.Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
      decoder: decoder,
      renderCache: renderCache,
      backgroundLoading: backgroundLoading,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
