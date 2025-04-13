// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/core/pref_data.dart';
import 'package:mathspuzzle/ui/app/app.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';
import 'package:mathspuzzle/ui/app/theme_provider.dart';
import 'package:mathspuzzle/ui/calculator/calculator_provider.dart';
import 'package:mathspuzzle/ui/complexCalculation/complex_calculation_provider.dart';
import 'package:mathspuzzle/ui/concentration/concentration_provider.dart';
import 'package:mathspuzzle/ui/correctAnswer/correct_answer_provider.dart';
import 'package:mathspuzzle/ui/dashboard/dashboard_provider.dart';
import 'package:mathspuzzle/ui/guessTheSign/guess_sign_provider.dart';
import 'package:mathspuzzle/ui/mathGrid/math_grid_provider.dart';
import 'package:mathspuzzle/ui/mathPairs/math_pairs_provider.dart';
import 'package:mathspuzzle/ui/numberPyramid/number_pyramid_provider.dart';
import 'package:mathspuzzle/ui/picturePuzzle/picture_puzzle_provider.dart';
import 'package:mathspuzzle/ui/quickCalculation/quick_calculation_provider.dart';
import 'package:mathspuzzle/utility/notification_init.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/magicTriangle/magic_triangle_provider.dart';


 Future<void> init() async {
   Get.lazyPut(() => DashboardProvider());
   Get.lazyPut(() => ThemeProvider());
   Get.lazyPut(() => GameProvider(gameCategoryType: GameCategoryType.CALCULATOR,));
   Get.lazyPut(() => CalculatorProvider(level: 1, ));
   Get.lazyPut(() => ComplexCalculationProvider(level: 1, ));
   Get.lazyPut(() => ConcentrationProvider(level: 1, nextQuiz: (){}, ));
   Get.lazyPut(() => CorrectAnswerProvider(level: 1, ));
   Get.lazyPut(() => GuessSignProvider(level: 1));
   Get.lazyPut(() => PicturePuzzleProvider(level: 1));
   Get.lazyPut(() => QuickCalculationProvider(level: 1));
   Get.lazyPut(() => NumberPyramidProvider(level: 1));
   Get.lazyPut(() => MathPairsProvider(level: 1));
   Get.lazyPut(() => MathGridProvider(level: 1));
   Get.lazyPut(() => MagicTriangleProvider(level: 1));
 }


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  // await Firebase.initializeApp();
  NotificationFile.init();
  // NotificationFile.initFirebase();

  final sharedPreferences = await SharedPreferences.getInstance();

  await init();
  setupServiceLocator(sharedPreferences);

  PrefData.init();

  runApp(MyApp());
}


 class FullScreen extends StatefulWidget {
   const FullScreen({Key? key}) : super(key: key);

   @override
   _FullScreenState createState() => _FullScreenState();
 }

 class _FullScreenState extends State<FullScreen> {
   @override
   void initState() {
     super.initState();
   }

   @override
   Widget build(BuildContext context) {

     SystemChrome.setSystemUIOverlayStyle(
         SystemUiOverlayStyle(
             statusBarColor: Colors.transparent,
             statusBarIconBrightness: Brightness.light
         )
     );
     return Scaffold(
       body: buildBody(),
     );
   }

   Widget buildBody() {
     return SizedBox(
       height: 400,
       width: double.infinity,
       child: Card(
         clipBehavior: Clip.antiAlias,
         margin: EdgeInsets.all(0),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.only(
               bottomLeft: Radius.circular(40),
               bottomRight: Radius.circular(40)),
         ),
         child: Image.network(
           'https://source.unsplash.com/random',
           fit: BoxFit.cover,
         ),
       ),
     );
   }
 }




setupServiceLocator(SharedPreferences sharedPreferences) {
   Get.lazyPut(() => DashboardProvider());
}

