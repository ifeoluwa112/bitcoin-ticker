import 'dart:convert';
import 'package:http/http.dart' as http;



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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '8F7B1D43-1243-46FB-A9D0-981758B84E71';

class CoinData {

  Future<Map<String, String>> getCoinData(String? selectedCurrency) async {

    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {

      http.Response response = await http.get(Uri.parse('$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey'));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
