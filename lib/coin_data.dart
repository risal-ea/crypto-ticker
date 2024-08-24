import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apikey = 'apikey';

class CoinData {
  Future<double?> getCoinData(String currency) async {
    String requestURL = '$coinApiUrl/BTC/$currency?apikey=$apikey';
    Uri uri = Uri.parse(requestURL);  // Convert the string to a Uri object
    http.Response response = await http.get(uri);  // Use the Uri object here

    if(response.statusCode == 200){
      var decodedData = jsonDecode(response.body);
      double price = decodedData['rate'];
      return price;
    }else{
      print('http Request failed with status: ${response.statusCode}.');
    }
  }
}