class CityDTO {
  final String city;
  final String country;

  CityDTO({
    required this.city,
    required this.country,
  });

  Map<String, dynamic> toJson() => {
        'city': city,
        'country': country,
      };

  @override
  String toString() {
    return '{city: $city, country: $country}';
  }

  factory CityDTO.fromJson(Map<String, dynamic> json) {
    return CityDTO(
      city: json['city'],
      country: json['country'],
    );
  }
}
