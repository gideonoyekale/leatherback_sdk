import 'package:flutter/painting.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SvgProvider;

import '../theme/palette.dart';
import 'assets.dart';

class Decorations {
  static DecorationImage darkLinePattern = const DecorationImage(
    image: SvgProvider.Svg(
      Assets.linePattern,
      source: SvgProvider.SvgSource.asset,
    ),
    colorFilter: ColorFilter.mode(
      Palette.white,
      BlendMode.difference,
    ),
    fit: BoxFit.cover,
    opacity: 0.5,
  );
}
