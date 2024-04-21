class Location {
  final double? latitude;
  final double? longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  // copyWith method allows for modification of some properties while keeping others unchanged
  Location copyWith({
    double? latitude,
    double? longitude,
  }) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

}
