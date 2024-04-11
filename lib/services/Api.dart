import 'dart:convert';
import 'package:http/http.dart' as http;

const urlApiConversion = "https://api.freecurrencyapi.com/v1/latest";
const String apiKey = "fca_live_S3oF9tI9LqlYm9GtDcSWXw211NeYSP4jXYV1sOvc";

Future<String> getCurrencyRateAsync(
  String from,
  String to,
) async {
  final urlWithQuery = Uri.parse(
      '$urlApiConversion?apikey=$apiKey&currencies=$to&base_currency=$from');
  final response = await http.get(urlWithQuery);
  print(urlWithQuery);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final currencyRate = data["data"][to];
    return currencyRate.toString();
  } else {
    throw Exception('Failed to load data');
  }
}
