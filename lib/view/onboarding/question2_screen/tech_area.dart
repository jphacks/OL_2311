enum TechArea {
  frontend,
  backend,
  infra,
  hardware,
  designer;

  String get label {
    switch (this) {
      case TechArea.frontend:
        return "フロントエンド";
      case TechArea.backend:
        return "バックエンド";
      case TechArea.infra:
        return "インフラ";
      case TechArea.hardware:
        return "ハードウェア";
      case TechArea.designer:
        return "デザイナー";
    }
  }
}
