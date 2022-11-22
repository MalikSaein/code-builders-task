import 'package:cbtask/controller/memes_controller.dart';
import 'package:cbtask/presentation/item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Making the widget stateful to uzilize init and dispose methods
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {

  //making permanent true to keeps the Instance in memory
  final controller = Get.put<MemesController>(MemesController(), permanent: true);

  @override
  void dispose() {
    Get.delete<MemesController>(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task'),
        ),
        body: GetBuilder<MemesController>(
            init: controller,
            id: MemesController.memeKey,
            assignId: true,
            builder: (value) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return buildItem(context, index, value);
                },
                itemCount: value.memesList?.length ?? 0,
              );
            }),
      ),
    );
  }

  Widget buildItem(
      BuildContext context, int index, MemesController controller) {
    return ItemView(meme: controller.memesList![index],);
  }
}
