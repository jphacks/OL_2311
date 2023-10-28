enum TechArea {
  frontend,
  backend,
  mobile,
  infra,
  game,
  machineLearning,
  other;

  String get label {
    switch (this) {
      case TechArea.frontend:
        return "フロントエンド";
      case TechArea.backend:
        return "バックエンド";
      case TechArea.mobile:
        return "モバイル";
      case TechArea.infra:
        return "インフラ";
      case TechArea.game:
        return "ゲーム";
      case TechArea.machineLearning:
        return "機械学習";
      case TechArea.other:
        return "その他";
    }
  }
}
