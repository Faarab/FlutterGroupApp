import 'dart:convert';
import 'package:triptaptoe_app/models/CityDTO.dart';

class CityService {
 Iterable<CityDTO> getCities() {
  final List<dynamic> citiesJson = jsonDecode(citiesJsonString);

  return citiesJson.map((json) => CityDTO.fromJson(json as Map<String, dynamic>));
}


  CityDTO getCityByName(String cityName) {
    final List<Map<String, dynamic>> citiesJson = jsonDecode(citiesJsonString);
    
    final cityJson = citiesJson.firstWhere(
      (city) => city['name'] == cityName,
      orElse: () => throw Exception('City $cityName not found'),
    );

    return CityDTO.fromJson(cityJson);
  }
  List<Map<String, dynamic>> getActivitiesByCategory(String category) {
    final List<Map<String, dynamic>> citiesJson = jsonDecode(citiesJsonString);
    List<Map<String, dynamic>> activities = [];

    for (var city in citiesJson) {
      city['activities'].forEach((activity) {
        if (activity['category'] == category) {
          activities.add(activity);
        }
      });
    }

    return activities;
  }
 Set<String> getCategories() {
  final List<dynamic> citiesJson = jsonDecode(citiesJsonString);
  Set<String> categories = Set();

  for (var cityData in citiesJson) {
    if (cityData.containsKey('activities')) {
      final List<dynamic> activities = cityData['activities'];
      for (var activity in activities) {
        categories.add(activity['category']);
      }
    }
  }

  return categories;
}


}

const citiesJsonString = """
[
  {
    "name": "Barcelona",
    "country": "Spain",
    "activities": [
      {
        "name": "Sagrada Família",
        "startTime": "2024-04-09T09:00:00.000Z",
        "openingTime": "2024-04-09T09:00:00.000Z",
        "closingTime": "2024-04-09T18:00:00.000Z",
        "location": "Carrer de Mallorca, 401, 08013 Barcelona, Spain",
        "price": null,
        "image": "sagrada_familia.jpg",
        "category": "Attractions"
      },
      {
        "name": "Park Güell",
        "startTime": "2024-04-09T10:00:00.000Z",
        "openingTime": "2024-04-09T08:00:00.000Z",
        "closingTime": "2024-04-09T21:00:00.000Z",
        "location": "08024 Barcelona, Spain",
        "price": null,
        "image": "img2.jpg",
        "category": "Parks"
      },
      {
        "name": "Casa Batlló",
        "startTime": "2024-04-09T09:00:00.000Z",
        "openingTime": "2024-04-09T09:00:00.000Z",
        "closingTime": "2024-04-09T20:00:00.000Z",
        "location": "Passeig de Gràcia, 43, 08007 Barcelona, Spain",
        "price": null,
        "image": "casa_batllo.jpg",
        "category": "Attractions"
      },
      {
        "name": "La Rambla",
        "startTime": "2024-04-09T08:00:00.000Z",
        "openingTime": "2024-04-09T08:00:00.000Z",
        "closingTime": "2024-04-09T00:00:00.000Z",
        "location": "La Rambla, 08002 Barcelona, Spain",
        "price": null,
        "image": "la_rambla.jpg",
        "category": "Food"
      },
      {
        "name": "Camp Nou",
        "startTime": "2024-04-09T09:00:00.000Z",
        "openingTime": "2024-04-09T09:00:00.000Z",
        "closingTime": "2024-04-09T20:00:00.000Z",
        "location": "C. d'Aristides Maillol, 12, 08028 Barcelona, Spain",
        "price": null,
        "image": "camp_nou.jpg",
        "category": "Attractions"
      },
      {
        "name": "Barcelona Zoo",
        "startTime": "2024-04-09T10:00:00.000Z",
        "openingTime": "2024-04-09T10:00:00.000Z",
        "closingTime": "2024-04-09T18:00:00.000Z",
        "location": "Parc de la Ciutadella, 08003 Barcelona, Spain",
        "price": null,
        "image": "camp_nou.jpg",
        "category": "Zoos"
      }
    ]
  },
  {
    "name": "Madrid",
    "country": "Spain",
    "activities": [
      {
        "name": "Museo del Prado",
        "startTime": "2024-04-09T09:00:00.000Z",
        "openingTime": "2024-04-09T09:00:00.000Z",
        "closingTime": "2024-04-09T20:00:00.000Z",
        "location": "Calle de Ruiz de Alarcón, 23, 28014 Madrid, Spain",
        "price": null,
        "image": "prado.jpg",
        "category": "Museums"
      },
      {
        "name": "Parque del Retiro",
        "startTime": "2024-04-09T08:00:00.000Z",
        "openingTime": "2024-04-09T08:00:00.000Z",
        "closingTime": "2024-04-09T22:00:00.000Z",
        "location": "Plaza de la Independencia, 7, 28001 Madrid, Spain",
        "price": null,
        "image": "retiro.jpg",
        "category": "Parks"
      },
      {
        "name": "Plaza Mayor",
        "startTime": "2024-04-09T08:00:00.000Z",
        "openingTime": "2024-04-09T08:00:00.000Z",
        "closingTime": "2024-04-09T00:00:00.000Z",
        "location": "Plaza Mayor, 28012 Madrid, Spain",
        "price": null,
        "image": "plaza.jpg",
        "category": "Squares"
      },
      {
        "name": "Royal Palace",
        "startTime": "2024-04-09T10:00:00.000Z",
        "openingTime": "2024-04-09T10:00:00.000Z",
        "closingTime": "2024-04-09T18:00:00.000Z",
        "location": "Calle de Bailén, s/n, 28071 Madrid, Spain",
        "price": null,
        "image": "la_rambla.jpg",
        "category": "Palaces"
      }
    ]
  },
  {
    "name": "Malaga",
    "country": "Spain",
    "activities": [
      {
        "name": "Alcazaba",
        "startTime": "2024-04-09T09:00:00.000Z",
        "openingTime": "2024-04-09T09:00:00.000Z",
        "closingTime": "2024-04-09T20:00:00.000Z",
        "location": "Calle Alcazabilla, 2, 29015 Málaga, Spain",
        "price": null,
        "image": "alcazaba.jpg",
        "category": "Historical Sites"
      },
      {
        "name": "Gibralfaro",
        "startTime": "2024-04-09T09:00:00.000Z",
        "openingTime": "2024-04-09T09:00:00.000Z",
        "closingTime": "2024-04-09T18:00:00.000Z",
        "location": "Camino Gibralfaro, s/n, 29016 Málaga, Spain",
        "price": null,
        "image": "gibralfaro.jpg",
        "category": "Historical Sites"
      },
      {
        "name": "Cathedral",
        "startTime": "2024-04-09T10:00:00.000Z",
        "openingTime": "2024-04-09T10:00:00.000Z",
        "closingTime": "2024-04-09T18:00:00.000Z",
        "location": "Calle Molina Lario, 9, 29015 Málaga, Spain",
        "price": null,
        "image": "cathedral.jpg",
        "category": "Religious Sites"
      },
      {
        "name": "Picasso Museum",
        "startTime": "2024-04-09T10:00:00.000Z",
        "openingTime": "2024-04-09T10:00:00.000Z",
        "closingTime": "2024-04-09T20:00:00.000Z",
        "location": "Calle San Agustín, 8, 29015 Málaga, Spain",
        "price": null,
        "image": "picasso.jpg",
        "category": "Museums"
      }
    ]
  }
]

""";
