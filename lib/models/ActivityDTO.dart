
class ActivityDTO {
  ActivityDTO({
    required this.name,
    required this.startTime,
    this.openingTime,
    this.closingTime,
    this.location,
    this.price,
    });
  final String name;
  final DateTime startTime;
  final DateTime? openingTime;
  final DateTime? closingTime;
  final String? location;
  final double? price;

  factory ActivityDTO.fromJson(Map<String, dynamic> json) => ActivityDTO(
    name: json["name"],
    startTime: DateTime.parse(json["startTime"]),
    openingTime: DateTime.parse(json["openingTime"]),
    closingTime: DateTime.parse(json["closingTime"]),
    location: json["location"],
    price: json["price"],
    );

  //da trasferire per essere resi usabili fuori dalla classe ActivityDTO
  String formatStartTime() {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
  }
  // String formatEndTime() {
  //   return '${openingTime.hour.toString().padLeft(2, '0')}:${openingTime.minute.toString().padLeft(2, '0')}';
  // }
  

  Map<String, dynamic> toJson() => {
    "name": name,
    "startTime": startTime,
    "openingTime": openingTime,
    "closingTime": closingTime,
    "location": location,
    "price": price,
    };

  @override
  String toString() {
    return '{name: $name, startTime: $startTime, openingTime: $openingTime, closingTime: $closingTime, location: $location, price: $price}';
  }
}