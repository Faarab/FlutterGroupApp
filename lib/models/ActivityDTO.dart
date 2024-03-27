
class ActivityDTO {
  ActivityDTO({
    required this.name,
    required this.startTime,
    this.openingTime,
    this.closingTime,
    this.location,
    this.price,
    this.image,
    });
    
  final String name;
  final DateTime startTime;
  final DateTime? openingTime;
  final DateTime? closingTime;
  final String? location;
  final double? price;
  final String? image;

  factory ActivityDTO.fromJson(Map<String, dynamic> json) => ActivityDTO(
    name: json["name"],
    startTime: DateTime.parse(json["startTime"]),
    openingTime: DateTime.parse(json["openingTime"]) ?? null,
    closingTime: DateTime.parse(json["closingTime"]) ?? null,
    location: json["location"] ?? null,
    price: json["price"] ?? null,
    image: json["image"] ?? null,
    );

  //da trasferire per essere resi usabili fuori dalla classe ActivityDTO
  String formatStartTime() {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
  }
  
  String formatOpeningClosingTime() {
  String _formatTime(DateTime time) {
    String period = time.hour < 12 ? 'AM' : 'PM';
    int hour = time.hour % 12;
    if (hour == 0) {
      hour = 12;
    }
    return '$hour:${time.minute.toString().padLeft(2, '0')}$period';
  }

  String openingTimeString = openingTime != null
      ? _formatTime(openingTime!)
      : 'N/A';
  String closingTimeString = closingTime != null
      ? _formatTime(closingTime!)
      : 'N/A';

  return '$openingTimeString - $closingTimeString';
}


  
  Map<String, dynamic> toJson() => {
    "name": name,
    "startTime": startTime,
    "openingTime": openingTime,
    "closingTime": closingTime,
    "location": location,
    "price": price,
    "image": image,
    };

  @override
  String toString() {
    return '{name: $name, startTime: $startTime, openingTime: $openingTime, closingTime: $closingTime, location: $location, price: $price, image: $image}';
  }
}