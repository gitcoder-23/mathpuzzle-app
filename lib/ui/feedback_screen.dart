import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:mathspuzzle/ui/resizer/fetch_pixels.dart';
import 'package:mathspuzzle/ui/resizer/widget_utils.dart';

import '../core/app_assets.dart';
import '../core/app_constant.dart';
import '../utility/Constants.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedbackScreen();
  }
}

class _FeedbackScreen extends State<FeedbackScreen> {
  void backClicks() {
    if (kIsWeb) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  ValueNotifier soundOn = ValueNotifier(false);
  ValueNotifier darkMode = ValueNotifier(false);
  ValueNotifier vibrateOn = ValueNotifier(false);

  double rate = 0;
  @override
  void initState() {
    super.initState();

    getSpeakerVol();
  }

  getSpeakerVol() async {
    soundOn.value = await getSound();
    vibrateOn.value = await getVibration();
    Future.delayed(Duration.zero, () {
      darkMode.value = Theme.of(context).brightness != Brightness.light;
    });
  }

  double fontTitleSize = 30;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    int selection = 1;

    Widget verSpace = SizedBox(height: FetchPixels.getPixelHeight(35));

    double margin = getHorizontalSpace(context);

    EdgeInsets edgeInsets = EdgeInsets.symmetric(
        horizontal: FetchPixels.getDefaultHorSpace(context));
    double starSize = FetchPixels.getPixelHeight(80);

    return WillPopScope(
      child: Scaffold(
        appBar: getNoneAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getScreenPercentSize(context, 2),
                ),
                getDefaultIconWidget(context,
                    icon: AppAssets.backIcon,
                    folder: KeyUtil.themeYellowFolder, function: () {
                  backClicks();
                }),
                buildExpandedData(edgeInsets, starSize, selection, context),
                getButtonWidget(
                  context,
                  "Submit Feedback",
                  KeyUtil.primaryColor1,
                  () async {
                    // if (rate >= 3) {
                      String feedback = "";

                      if (feedbackController.value.text.isNotEmpty) {
                        feedback = feedbackController.text.toString();
                      }

                      print("Dfsdf");
                      if (Platform.isIOS) {
                        final bool canSend =
                        await FlutterMailer.canSendMail();


                        if (!canSend) {
                          const SnackBar snackbar = const SnackBar(
                              content: Text("no Email App Available"));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbar);
                          return;
                        }
                      }

                      final MailOptions mailOptions = MailOptions(
                        body:feedback,
                        recipients: [feedbackMail],
                        isHTML: true,
                      );
                      await FlutterMailer.send(mailOptions);


                    // }
                  },
                  textColor: Theme.of(context).textTheme.bodySmall!.color,
                ),
                getVerSpace(FetchPixels.getPixelHeight(75)),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        backClicks();
        return false;
      },
    );
  }

  TextEditingController feedbackController = TextEditingController();

  Expanded buildExpandedData(EdgeInsets edgeInsets, double starSize,
      int selection, BuildContext context) {
    Color fontColor = Theme.of(context).textTheme.titleSmall!.color!;
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        primary: true,
        padding: edgeInsets,
        children: [
          getVerSpace(FetchPixels.getPixelHeight(90)),
          getCustomFont("Give Feedback", 53, fontColor, 1,
              fontWeight: FontWeight.w900),
          getVerSpace(FetchPixels.getPixelHeight(25)),
          getCustomFont("Give your feedback about our app", 35, fontColor, 1,
              fontWeight: FontWeight.w500),
          getVerSpace(FetchPixels.getPixelHeight(100)),
          getCustomFont("Are you satisfied with this app?", 35, fontColor, 1,
              fontWeight: FontWeight.w800),
          getVerSpace(FetchPixels.getPixelHeight(45)),
          RatingBar(
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(30)),
              allowHalfRating: false,
              itemSize: starSize,
              initialRating: 0,
              updateOnDrag: true,
              glowColor: Theme.of(context).scaffoldBackgroundColor,
              ratingWidget: RatingWidget(
                full: getSvgImageWithSize(
                    context, "star_fill.svg", starSize, starSize),
                empty: getSvgImageWithSize(
                    context, "star.svg", starSize, starSize),
                half: getSvgImageWithSize(
                    context, "star_fill.svg", starSize, starSize),
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  rate = rating;
                });
              }),
          getVerSpace(FetchPixels.getPixelHeight(140)),
          getCustomFont("Tell us what can be improved!", 35, fontColor, 1,
              fontWeight: FontWeight.w800),
          getVerSpace(FetchPixels.getPixelHeight(40)),
          getDefaultTextFiled(context, "Write your feedback...",
              feedbackController, fontColor, Colors.grey,
              minLines: true)
        ],
      ),
      flex: 1,
    );
  }
}
