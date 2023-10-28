enum Location {
  hokkaidoTohoku,
  kanto,
  chubu,
  kinki,
  chugokuShikoku,
  kyushuOkinawa,
  overseas;

  String get label {
    switch (this) {
      case Location.hokkaidoTohoku:
        return "北海道・東北";
      case Location.kanto:
        return "関東";
      case Location.chubu:
        return "中部";
      case Location.kinki:
        return "近畿";
      case Location.chugokuShikoku:
        return "中国・四国";
      case Location.kyushuOkinawa:
        return "九州・沖縄";
      case Location.overseas:
        return "海外";
    }
  }
}
