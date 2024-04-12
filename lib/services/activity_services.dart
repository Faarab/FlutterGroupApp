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
//TODO utilizzare questo json per inserire due alternative di attività. Implementare logica.

// {
//   "results": [
//     {
//       "name": "Museo del Prado",
//       "startTime": "2024-04-09T09:00:00.000Z",
//       "openingTime": "2024-04-09T09:00:00.000Z",
//       "closingTime": "2024-04-09T20:00:00.000Z",
//       "location": "Calle de Ruiz de Alarcón, 23, 28014 Madrid, Spain",
//       "price": null,
//       "image": "prado_museum.jpg",
//       "category": "Museums"
//     },
//     {
//       "name": "Parque del Retiro",
//       "startTime": "2024-04-09T08:00:00.000Z",
//       "openingTime": "2024-04-09T08:00:00.000Z",
//       "closingTime": "2024-04-09T22:00:00.000Z",
//       "location": "Plaza de la Independencia, 7, 28001 Madrid, Spain",
//       "price": null,
//       "image": "retiro_park.jpg",
//       "category": "Parks"
//     },
//     {
//       "name": "Plaza Mayor",
//       "startTime": "2024-04-09T08:00:00.000Z",
//       "openingTime": "2024-04-09T08:00:00.000Z",
//       "closingTime": "2024-04-09T00:00:00.000Z",
//       "location": "Plaza Mayor, 28012 Madrid, Spain",
//       "price": null,
//       "image": "plaza_mayor.jpg",
//       "category": "Squares"
//     },
//     {
//       "name": "Royal Palace of Madrid",
//       "startTime": "2024-04-09T10:00:00.000Z",
//       "openingTime": "2024-04-09T10:00:00.000Z",
//       "closingTime": "2024-04-09T18:00:00.000Z",
//       "location": "Calle de Bailén, s/n, 28071 Madrid, Spain",
//       "price": null,
//       "image": "royal_palace.jpg",
//       "category": "Palaces"
//     },
//     {
//       "name": "Thyssen-Bornemisza Museum",
//       "startTime": "2024-04-09T10:00:00.000Z",
//       "openingTime": "2024-04-09T10:00:00.000Z",
//       "closingTime": "2024-04-09T19:00:00.000Z",
//       "location": "Paseo del Prado, 8, 28014 Madrid, Spain",
//       "price": null,
//       "image": "thyssen_museum.jpg",
//       "category": "Museums"
//     },
//     {
//       "name": "Gran Vía",
//       "startTime": "2024-04-09T08:00:00.000Z",
//       "openingTime": "2024-04-09T08:00:00.000Z",
//       "closingTime": "2024-04-09T00:00:00.000Z",
//       "location": "Gran Vía, 28013 Madrid, Spain",
//       "price": null,
//       "image": "gran_via.jpg",
//       "category": "Shopping"
//     },
//     {
//       "name": "Puerta del Sol",
//       "startTime": "2024-04-09T08:00:00.000Z",
//       "openingTime": "2024-04-09T08:00:00.000Z",
//       "closingTime": "2024-04-09T00:00:00.000Z",
//       "location": "Puerta del Sol, 28013 Madrid, Spain",
//       "price": null,
//       "image": "puerta_del_sol.jpg",
//       "category": "Squares"
//     },
//     {
//       "name": "Temple of Debod",
//       "startTime": "2024-04-09T09:00:00.000Z",
//       "openingTime": "2024-04-09T09:00:00.000Z",
//       "closingTime": "2024-04-09T20:00:00.000Z",
//       "location": "Calle Ferraz, 1, 28008 Madrid, Spain",
//       "price": null,
//       "image": "temple_of_debod.jpg",
//       "category": "Historical Sites"
//     }
//   ]
// }
