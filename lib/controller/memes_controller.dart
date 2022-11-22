import 'dart:convert';
import 'dart:developer';

import 'package:cbtask/repository/get_list_repo.dart';
import 'package:cron/cron.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

import '../models/meme_model.dart';

class MemesController extends GetxController {
  static String memeKey = "memeCKey";
  final cron = Cron();
  GetListDataRepo getListDataRepo = GetListDataRepo();
  List<MemeModel>? memesList;

  @override
  Future<void> onInit() async {
    getMemes();
    if(!getListDataRepo.isCronJobAlreadyScheduled()){
      scheduleSoundModeChangedJob();
    }
    super.onInit();
  }

  getMemes() async {
      memesList = getListDataRepo.getMemesFromCache() ?? [];
      update([memeKey]);
      memesList = await getListDataRepo.getMemesList();
      update([memeKey]);
  }

  scheduleSoundModeChangedJob(){
    cron.schedule(Schedule.parse('00 22,8 * * *'), () async {
      final  bool? isGranted = await PermissionHandler.permissionsGranted;
      if (!isGranted!) {
        // Opens the Do Not Disturb Access settings to grant the access
        await PermissionHandler.openDoNotDisturbSetting();
        scheduleSoundModeChangedJob();
      } else{
        var ringerStatus = await SoundMode.ringerModeStatus;
        print(ringerStatus);
        if(ringerStatus.name == RingerModeStatus.silent.name || ringerStatus.name == RingerModeStatus.vibrate.name){
          try {
            await SoundMode.setSoundMode(RingerModeStatus.normal);
          } on PlatformException {
            print('Please enable permissions required');
          }
        } else if(ringerStatus.name == RingerModeStatus.normal.name){
          try {
            await SoundMode.setSoundMode(RingerModeStatus.vibrate);
          } on PlatformException {
            print('Please enable permissions required');
          }
        }

      }
    });
  }
}
