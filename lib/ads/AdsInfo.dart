import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';


AdRequest request = AdRequest(
  keywords: <String>['foo', 'bar'],
  contentUrl: 'http://foo.com/bar.html',
  nonPersonalizedAds: true,


);

String getInterstitialAdUnitId() {
  if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/1033173712';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/4411468910';
  }
  return "";
}

String getRewardBasedVideoAdUnitId() {
  if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/5224354917';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/1712485313';
  }
  return "";
}

String getBannerAdUnitId() {
  if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/6300978111';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/2934735716';
  }
  return "";
}
