import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game_provider.dart';

class CoinProvider extends GetxController {
// class CoinProvider with ChangeNotifier {
  int coin = 0;
  String keyCoin = 'KeyCoin';

  // getCoin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   coin = prefs.getInt(keyCoin) ?? 0;
  //
  //   print("coin===$coin");
  //   notifyListeners();
  // }
  //
  // addCoin() async {
  //   print("coin===12 $coin");
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt(keyCoin, (coin + rightCoin));
  //   getCoin();
  // }
  //
  // minusCoin({int? useCoin}) async {
  //   int i = (useCoin == null) ? wrongCoin : useCoin;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt(keyCoin, ((coin - i) >= 0) ? (coin - i) : 0);
  //   getCoin();
  // }


}
