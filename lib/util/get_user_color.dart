import 'dart:ui';

abstract class TechAreaStruct {
  String get label;
  String get ringImage;
  String get lockImage;
  String get panelBgImage;
  Color get cardBgGradientBegin;
  Color get cardBgGradientEnd;
  Color get panelUnderTextBgGradientBegin;
  Color get panelUnderTextBgGradientEnd;
  Color get solidBgColor;

  static TechAreaStruct fromText(String? techArea) {
    switch (techArea) {
      case "フロントエンド":
        return FrontendStruct();
      case "バックエンド":
        return BackendStruct();
      case "デザイナー":
        return DesignerStruct();
      case "ハードウェア":
        return HardwareStruct();
    }
    return HardwareStruct();
  }
}

class FrontendStruct implements TechAreaStruct {
  @override
  final String label = "フロントエンド";
  @override
  final String ringImage = "assets/images/ring-green.png";
  @override
  final String lockImage = "assets/images/lock-green.png";
  @override
  final String panelBgImage = 'assets/images/panel-green.png';
  @override
  final Color cardBgGradientBegin = const Color(0xFFC5E7AF);
  @override
  final Color cardBgGradientEnd = const Color(0xFFCEE8CA);
  @override
  final Color panelUnderTextBgGradientBegin = const Color(0xff94E992);
  @override
  final Color panelUnderTextBgGradientEnd =
      const Color(0xffA5EBA3).withOpacity(0.5);

  @override
  final Color solidBgColor = const Color(0xff44C341);
}

class BackendStruct implements TechAreaStruct {
  @override
  final String label = "バックエンド";
  @override
  final String ringImage = "assets/images/ring-purple.png";
  @override
  final String lockImage = "assets/images/lock-purple.png";
  @override
  final String panelBgImage = 'assets/images/panel-purple.png';
  @override
  final Color cardBgGradientBegin = const Color(0xFFB9B5E2);
  @override
  final Color cardBgGradientEnd = const Color(0xFFD9D0EC);
  @override
  final Color panelUnderTextBgGradientBegin = const Color(0xffB992E9);
  @override
  final Color panelUnderTextBgGradientEnd =
      const Color(0xffEDAEDB).withOpacity(0.5);

  @override
  final Color solidBgColor = const Color(0xffC367EC);
}

class DesignerStruct implements TechAreaStruct {
  @override
  final String label = "デザイナー";
  @override
  final String ringImage = "assets/images/ring-red.png";
  @override
  final String lockImage = "assets/images/lock-red.png";
  @override
  final String panelBgImage = 'assets/images/panel-red.png';
  @override
  final Color cardBgGradientBegin = const Color(0xFFEEAFAB);
  @override
  final Color cardBgGradientEnd = const Color(0xFFEBD2CA);
  @override
  final Color panelUnderTextBgGradientBegin = const Color(0xffE99298);
  @override
  final Color panelUnderTextBgGradientEnd =
      const Color(0xffEBA3A8).withOpacity(0.5);

  @override
  final Color solidBgColor = const Color(0xffE64C49);
}

class HardwareStruct implements TechAreaStruct {
  @override
  final String label = "ハードウェア";
  @override
  final String ringImage = "assets/images/ring-blue.png";
  @override
  final String lockImage = "assets/images/lock-blue.png";
  @override
  final String panelBgImage = 'assets/images/panel-blue.png';
  @override
  final Color cardBgGradientBegin = const Color(0xFF86DFE6);
  @override
  final Color cardBgGradientEnd = const Color(0xFFB8E5EA);
  @override
  final Color panelUnderTextBgGradientBegin = const Color(0xff7BD7F6);
  @override
  final Color panelUnderTextBgGradientEnd =
      const Color(0xff7DE8EF).withOpacity(0.5);

  @override
  final Color solidBgColor = const Color(0xff24AFDA);
}
