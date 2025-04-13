import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:get/get.dart';
import 'package:mathspuzzle/utility/Constants.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AudioPlayer{


  audio.AudioPlayer? audioCache = audio.AudioPlayer();

  RxBool? _isSound = true.obs;
  bool? _isVibrate = true;



  AudioPlayer(){

    setSound();
  }


  setSound()async{

    print("print_sound-------${await getSound()}}");
    _isSound!.value = await getSound();
    _isVibrate = await getVibration();
  }

  void playWrongSound() async {
    if(await getVibration()){
      Vibrate.vibrate();
    }
  }

  void playGameOverSound() async {
      playAudio(gameOverSound);
  }

  void playRightSound() async {
      playAudio(rightSound);
  }

  void playTickSound() async {
      playAudio(tickSound);
  }


  void playAudio(String s) async {
    if (await getSound() && audioCache != null) {
      try{
        await audioCache!.play(audio.AssetSource(s));
      }on Exception  catch(_) {

      }
    }
  }

  void stopAudio() async {
    if (await getSound() && audioCache != null) {
      await audioCache!.dispose();
    }
  }


}