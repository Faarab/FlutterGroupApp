
class ActivityDTO {
  ActivityDTO({
    required this.name,
    required this.startTime,
    required this.endTime,
    this.location,
    this.price,
    });
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final String? location;
  final double? price;

  factory ActivityDTO.fromJson(Map<String, dynamic> json) => ActivityDTO(
    name: json["name"],
    startTime: DateTime.parse(json["startTime"]),
    endTime: DateTime.parse(json["endTime"]),
    location: json["location"],
    price: json["price"],
    );

  //da trasferire per essere resi usabili fuori dalla classe ActivityDTO
  String formatStartTime() {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
  }
  String formatEndTime() {
    return '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
  }
  //

  Map<String, dynamic> toJson() => {
    "name": name,
    "startTime": startTime,
    "endTime": endTime,
    "location": location,
    "price": price,
    };

  @override
  String toString() {
    return '{name: $name, startTime: $startTime, endTime: $endTime, location: $location, price: $price}';
  }
}