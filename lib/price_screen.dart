import 'package:bitcoin_ticker/cryptoCurrencyTrackService.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = 'USD';
  CryptoCurrencyTrackService _crytoTrackerService = new CryptoCurrencyTrackService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: new CryptoCard(
              cryptoSymbol: 'BTC',
              currencyType: _selectedCurrency,
              lastValue: "100.0",
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: _currencyPicker(),
          ),
        ],
      ),
    );
  }


  Widget _currencyPicker() {
    return Platform.isAndroid
        ? _buildAndroidCurrencyPicker()
        : _buildIOSCurrencyPicker();
  }

  CupertinoPicker _buildIOSCurrencyPicker() {
    return CupertinoPicker(
        itemExtent: 30.0,
        onSelectedItemChanged: (index) {
          setState(() {
            _selectedCurrency = cryptoList[index].toString();
          });
        },
        children: currenciesList.map((s) => Text(s)).toList());
  }

  DropdownButton _buildAndroidCurrencyPicker() {
    return DropdownButton(
      value: _selectedCurrency,
      items: currenciesList.map((s) {
        return DropdownMenuItem<String>(value: s, child: Text(s));
      }).toList(),
      onChanged: (selectedValue) {
        setState(() {
          _selectedCurrency = selectedValue;
        });
      },
    );
  }
}

class CryptoCard extends StatelessWidget {
  
  final String cryptoSymbol;
  final String currencyType;
  final String lastValue;

  const CryptoCard({
    Key key, @required this.cryptoSymbol, @required this.currencyType, @required this.lastValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoSymbol = $lastValue $currencyType',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}
