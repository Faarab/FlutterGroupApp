
class ActivityDTO {
  ActivityDTO( {
    required this.name,
    required this.startTime,
    this.openingTime,
    this.closingTime,
    this.location,
    this.price,
    this.image,
    this.category

    });
    
  final String name;
  final DateTime startTime;
  final DateTime? openingTime;
  final DateTime? closingTime;
  final String? location;
  final double? price;
  final String? image;
  final String? category;

  factory ActivityDTO.fromJson(Map<String, dynamic> json) => ActivityDTO(
    name: json["name"],
    startTime: DateTime.parse(json["startTime"]),
    openingTime: DateTime.parse(json["openingTime"]),
    closingTime: DateTime.parse(json["closingTime"]),
    location: json["location"],
    price: json["price"],
    image: json["image"],
    category: json["category"]
    );


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
    "startTime": startTime.toIso8601String(),
    "openingTime": openingTime != null ? openingTime!.toIso8601String() : null,
    "closingTime": closingTime != null ? closingTime!.toIso8601String() : null,
    "location": location,
    "price": price,
    "image": image,
    "category": category
    };


  @override
  String toString() {
    return '{name: $name, startTime: $startTime, openingTime: $openingTime, closingTime: $closingTime, location: $location, price: $price, image: $image, category: $category}';
  }
}