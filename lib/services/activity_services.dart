import 'dart:convert';
import 'package:triptaptoe_app/models/ActivityDTO.dart';



class ActivityService {

  Iterable<ActivityDTO> getActivity({int results = 20}) {
    final Map<String, dynamic> data = jsonDecode(activitiesJson);

    final toReturn = List<ActivityDTO>.from(
        data['results']!.map((x) => ActivityDTO.fromJson(x)).take(results));

    return toReturn;
  }

  List<String> getCategories() {
    final Map<String, dynamic> data = jsonDecode(activitiesJson);

    List<String> categories = [];

    data['results']!.forEach((activity) {
      final category = activity['category'] as String;
      if (!categories.contains(category)) {
        categories.add(category);
      }
    });

    return categories;
  }


}



const activitiesJson= """
  {"results":
  [
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
  },
  {
    "name": "Montjuïc Cable Car",
    "startTime": "2024-04-09T10:00:00.000Z",
    "openingTime": "2024-04-09T10:00:00.000Z",
    "closingTime": "2024-04-09T18:00:00.000Z",
    "location": "Avinguda Miramar, 08038 Barcelona, Spain",
    "price": null,
    "image": "camp_nou.jpg",
    "category": "Transportation"
  },
  {
    "name": "Picasso Museum",
    "startTime": "2024-04-09T10:00:00.000Z",
    "openingTime": "2024-04-09T10:00:00.000Z",
    "closingTime": "2024-04-09T19:00:00.000Z",
    "location": "Carrer Montcada, 15-23, 08003 Barcelona, Spain",
    "price": null,
    "image": "camp_nou.jpg",
    "category": "Museums"
  },
  {
    "name": "Barcelona Aquarium",
    "startTime": "2024-04-09T10:00:00.000Z",
    "openingTime": "2024-04-09T10:00:00.000Z",
    "closingTime": "2024-04-09T19:00:00.000Z",
    "location": "Moll d'Espanya del Port Vell, s/n, 08039 Barcelona, Spain",
    "price": null,
    "image": "camp_nou.jpg",
    "category": "Aquariums"
  }]}
""";