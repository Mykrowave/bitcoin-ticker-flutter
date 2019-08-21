import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoCurrencyTrackService {
  final serviceDomain = 'https://apiv2.bitcoinaverage.com';

  Future<double> getCryptoLastPrice(
      String cryptoSymbol, String currencySymbol) async {
    String url =
        "$serviceDomain/indices/global/ticker/$cryptoSymbol$currencySymbol";

    http.Response cryptoResponse = await http.get(url);

    if (cryptoResponse.statusCode == 200) {
      // parse the double out
      dynamic cryptoData = jsonDecode(cryptoResponse.body);
      double lastValue = cryptoData["last"];
      print(lastValue.toString());
      return lastValue;
    }

    return null;
  }
}
