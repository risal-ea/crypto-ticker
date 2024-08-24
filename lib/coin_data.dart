import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:math'; // Import the dart:math library

const List<String> currenciesList = [
  'AUD', 'BRL', 'CAD', 'CNY', 'EUR', 'GBP', 'HKD', 'IDR', 'ILS',
  'INR', 'JPY', 'MXN', 'NOK', 'NZD', 'PLN', 'RON', 'RUB', 'SEK',
  'SGD', 'USD', 'ZAR'
];

const List<String> cryptoList = [
  'BTC', 'ETH', 'LTC',
];

const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apikey = 'apikey';

class CoinData {
  Future<Map<String, String>> getCoinData(String currency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String requestURL = '$coinApiUrl/$crypto/$currency?apikey=$apikey';
      Uri uri = Uri.parse(requestURL);

      bool success = false;
      int attempt = 0;
      while (!success && attempt < 5) {
        try {
          http.Response response = await http.get(uri);
          if (response.statusCode == 200) {
            var decodedData = jsonDecode(response.body);
            double price = decodedData['rate'];
            cryptoPrices[crypto] = price.toStringAsFixed(2);
            success = true;
          } else if (response.statusCode == 429) {
            // Handle rate limit with exponential backoff
            attempt++;
            int delay = (pow(2, attempt) as int); // Convert num to int
            print('Rate limit exceeded. Retrying in $delay seconds...');
            await Future.delayed(Duration(seconds: delay));
          } else {
            print('HTTP request failed with status: ${response.statusCode}.');
            break; // Exit loop if other errors occur
          }
        } catch (e) {
          print('An error occurred: $e');
          attempt++;
          if (attempt < 5) {
            int delay = (pow(2, attempt) as int); // Convert num to int
            print('Retrying in $delay seconds...');
            await Future.delayed(Duration(seconds: delay));
          }
        }
      }
    }

    return cryptoPrices;
  }
}
