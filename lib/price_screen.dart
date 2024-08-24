import 'package:crypto_ticker/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String items in currenciesList) {
      String currency = items;
      var newItems = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropDownItems.add(newItems);
    }
    return dropDownItems;
  }

  @override
  Widget build(BuildContext context) {
    getDropDownItems();

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Crypto Ticker'),
        backgroundColor: Color(0xFF17153B),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Color(0xFF17153B),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF17153B),
            child: DropdownButton<String>(
              value: selectedCurrency, // Set the current selected value
              items: getDropDownItems(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value!;
                });
                print(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
