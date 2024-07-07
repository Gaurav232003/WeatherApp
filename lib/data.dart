class history {
  history(
      {required this.cityName,
      required this.temp,
      required this.icon,
      required this.message});
  String cityName;
  String temp;
  String icon;
  String message;
}

int count = 0;
List<history> hist = [];
