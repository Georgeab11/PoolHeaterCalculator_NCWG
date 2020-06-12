class WeatherData {
  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int id;
  String name;
  int cod;

  WeatherData(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.id,
      this.name,
      this.cod});

  WeatherData.fromJson(Map<String, dynamic> json) {
    print('1');
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = new List<Weather>();
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    print('2');
    base = json['base'];
    print('3');
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    print('4');
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    print('5');
    clouds =
        json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    print('6');
    dt = json['dt'];
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coord != null) {
      data['coord'] = this.coord.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    data['base'] = this.base;
    if (this.main != null) {
      data['main'] = this.main.toJson();
    }
    if (this.wind != null) {
      data['wind'] = this.wind.toJson();
    }
    if (this.clouds != null) {
      data['clouds'] = this.clouds.toJson();
    }
    data['dt'] = this.dt;
    if (this.sys != null) {
      data['sys'] = this.sys.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['cod'] = this.cod;
    return data;
  }
}

class Coord {
  double lon;
  double lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    return data;
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Main {
  dynamic temp;
  dynamic pressure;
  dynamic humidity;
  dynamic tempMin;
  dynamic tempMax;
  dynamic seaLevel;
  dynamic grndLevel;

  Main(
      {this.temp,
      this.pressure,
      this.humidity,
      this.tempMin,
      this.tempMax,
      this.seaLevel,
      this.grndLevel});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['sea_level'] = this.seaLevel;
    data['grnd_level'] = this.grndLevel;
    return data;
  }
}

class Wind {
  double speed;
  int deg;

  Wind({this.speed, this.deg});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['deg'] = this.deg;
    return data;
  }
}

class Clouds {
  int all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    return data;
  }
}

class Sys {
  double message;
  String country;
  int sunrise;
  int sunset;

  Sys({this.message, this.country, this.sunrise, this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['country'] = this.country;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}
