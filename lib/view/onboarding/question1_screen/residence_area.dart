enum ResidenceArea {
  hokkaidoTohoku,
  kanto,
  chubu,
  kinki,
  chugokuShikoku,
  kyushuOkinawa,
  overseas;

  String get label {
    switch (this) {
      case ResidenceArea.hokkaidoTohoku:
        return "北海道・東北";
      case ResidenceArea.kanto:
        return "関東";
      case ResidenceArea.chubu:
        return "中部";
      case ResidenceArea.kinki:
        return "近畿";
      case ResidenceArea.chugokuShikoku:
        return "中国・四国";
      case ResidenceArea.kyushuOkinawa:
        return "九州・沖縄";
      case ResidenceArea.overseas:
        return "海外";
    }
  }
}
