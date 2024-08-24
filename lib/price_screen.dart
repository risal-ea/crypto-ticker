import 'package:crypto_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  Map<String, String> coinValue = {};

  void getData() async {
    try {
      CoinData coinData = CoinData();
      Map<String, String> prices = await coinData.getCoinData(selectedCurrency);
      setState(() {
        coinValue = prices;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  // Method to create a list of Text widgets for CupertinoPicker
  List<Widget> getPickerItems() {
    List<Widget> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(
        Center(
          child: Text(
            currency,
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    return pickerItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Crypto Ticker'),
        centerTitle: true,
        backgroundColor: Color(0xFF17153B),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (String crypto in cryptoList)
            card_widget(
              cryptoPrice: coinValue[crypto],
              selectedCurrency: selectedCurrency,
              cryptoSymbol: crypto, // Pass the crypto symbol to the widget
            ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF17153B),
            child: CupertinoPicker(
              itemExtent: 32.0,
              magnification: 1.3,
              onSelectedItemChanged: (selectedIndex) {
                setState(() {
                  selectedCurrency = currenciesList[selectedIndex];
                });
                print(selectedCurrency);
                getData();
              },
              children:
                  getPickerItems(), // Use getPickerItems to create picker items
            ),
          ),
        ],
      ),
    );
  }
}

class card_widget extends StatelessWidget {
  const card_widget({
    super.key,
    required this.cryptoPrice,
    required this.selectedCurrency,
    required this.cryptoSymbol,
  });

  final String? cryptoPrice;
  final String selectedCurrency;
  final String cryptoSymbol;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 $cryptoSymbol = ${cryptoPrice ?? 'Loading...'} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
