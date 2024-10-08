class Autogenerated {
  String? msg;
  List<Planets>? data;

  Autogenerated({this.msg, this.data});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Planets>[];
      json['data'].forEach((v) {
        data!.add(Planets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

double? parseVolume(dynamic volumeValue) {
  if (volumeValue == null) return null;

  // Asegúrate de que el valor esté en el formato correcto
  String volumeStr;
  if (volumeValue is String) {
    volumeStr = volumeValue;
  } else if (volumeValue is int) {
    volumeStr = volumeValue.toString();
  } else if (volumeValue is double) {
    volumeStr = volumeValue.toString();
  } else {
    print("Error: tipo de valor no válido para volume_km3: $volumeValue");
    return null;
  }

  // Reemplaza el "x10^" con "e" para la notación científica
  volumeStr = volumeStr.replaceAll(" x 10^", "e");
  // Elimina separadores de miles
  volumeStr = volumeStr.replaceAll(".", "");

  try {
    return double.parse(volumeStr);
  } catch (e) {
    print("Error al convertir el valor (volume_km3): $volumeStr - Error: $e");
    return null;
  }
}

class Planets {
  String name;
  int? orbitalDistanceKm; // Esta propiedad debe ser un int
  int? equatorialRadiusKm;
  double? volumeKm3; // Cambiado a double para mayor flexibilidad
  String massKg; // Se mantiene como String
  double? densityGCm3;
  double? surfaceGravityMS2;
  int? escapeVelocityKmh;
  double? dayLengthEarthDays;
  double? yearLengthEarthDays;
  int? orbitalSpeedKmh;
  String? atmosphereComposition;
  int? moons;
  String image;
  String description;
  int? yearLengthEarthYears;

  Planets({
    required this.name,
    this.orbitalDistanceKm,
    this.equatorialRadiusKm,
    this.volumeKm3,
    required this.massKg,
    this.densityGCm3,
    this.surfaceGravityMS2,
    this.escapeVelocityKmh,
    this.dayLengthEarthDays,
    this.yearLengthEarthDays,
    this.orbitalSpeedKmh,
    this.atmosphereComposition,
    this.moons,
    required this.image,
    required this.description,
    this.yearLengthEarthYears,
  });

  Planets.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        orbitalDistanceKm = json['orbital_distance_km']?.toInt(),
        equatorialRadiusKm = json['equatorial_radius_km']?.toInt(),
        volumeKm3 = parseVolume(
            json['volume_km3']), // Uso del método para limpiar y convertir
        massKg = json['mass_kg']?.toString() ??
            '', // Asegurando que siempre sea un string
        densityGCm3 = json['density_g_cm3']?.toDouble(),
        surfaceGravityMS2 = json['surface_gravity_m_s2']?.toDouble(),
        escapeVelocityKmh = json['escape_velocity_kmh']?.toInt(),
        dayLengthEarthDays = json['day_length_earth_days']?.toDouble(),
        yearLengthEarthDays = json['year_length_earth_days']?.toDouble(),
        orbitalSpeedKmh = json['orbital_speed_kmh']?.toInt(),
        atmosphereComposition = json['atmosphere_composition'],
        moons = json['moons']?.toInt(),
        image = json['image'],
        description = json['description'],
        yearLengthEarthYears = json['year_length_earth_years']?.toInt();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['orbital_distance_km'] = orbitalDistanceKm;
    data['equatorial_radius_km'] = equatorialRadiusKm;
    data['volume_km3'] = volumeKm3;
    data['mass_kg'] = massKg; // Se mantiene como String
    data['density_g_cm3'] = densityGCm3;
    data['surface_gravity_m_s2'] = surfaceGravityMS2;
    data['escape_velocity_kmh'] = escapeVelocityKmh;
    data['day_length_earth_days'] = dayLengthEarthDays;
    data['year_length_earth_days'] = yearLengthEarthDays;
    data['orbital_speed_kmh'] = orbitalSpeedKmh;
    data['atmosphere_composition'] = atmosphereComposition;
    data['moons'] = moons;
    data['image'] = image;
    data['description'] = description;
    data['year_length_earth_years'] = yearLengthEarthYears;
    return data;
  }

  static double? _parseVolumeKm3(dynamic value) {
    if (value == null) {
      return null; // Retorna null si el valor es nulo
    }

    if (value is int) {
      return value.toDouble(); // Convierte int a double
    }

    if (value is double) {
      return value; // Retorna el valor como está
    }

    if (value is String) {
      try {
        return double.parse(
            value.replaceAll(' ', '')); // Limpiar y convertir a double
      } catch (e) {
        print('Error al convertir el valor (volume_km3): $value - Error: $e');
        return null; // Retorna null en caso de error
      }
    }

    return null; // Retorna null si no se puede procesar el valor
  }
}
