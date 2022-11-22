import 'dart:convert';
import 'dart:developer';

import 'package:cbtask/models/meme_model.dart';
import 'package:cbtask/services/api_calls.dart';
import 'package:get_storage/get_storage.dart';

class GetListDataRepo {
  Future<List<MemeModel>?> getMemesList() async {
    List<MemeModel>? memesList;
    GetStorage storage = GetStorage();
    final response = await ApiCalls.apiGetMemes();
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['success']) {
        memesList = (jsonDecode(response.body)['data']['memes'] as List)
            .map((e) => MemeModel.fromJson(e))
            .toList();
        storage.write(
            'memesList', jsonEncode(memesList.map((e) => e.toJson()).toList()));
      }
    }
    return memesList;
  }

  List<MemeModel>? getMemesFromCache() {
    var tempList;
    GetStorage storage = GetStorage();
    if(storage.read('memesList') != null){
      tempList = List<MemeModel>.from(jsonDecode(storage.read('memesList'))
          .map((e) => MemeModel.fromJson(e)));
    }
    return tempList;
  }

  bool isCronJobAlreadyScheduled(){
    GetStorage storage = GetStorage();
    if(storage.read('isCronJobAlreadyCalled') == null){
      storage.write('isCronJobAlreadyCalled', true);
      return true;
    }
    return false;
  }
}
