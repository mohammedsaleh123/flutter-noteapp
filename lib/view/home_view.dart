import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/consts/color_const.dart';
import 'package:noteapp/consts/text_const.dart';
import 'package:noteapp/controller/controller.dart';
import 'package:noteapp/view/components/custom_text.dart';
import 'package:noteapp/view/widgets/add_dialog_widget.dart';
import 'package:noteapp/view/widgets/notes_body.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({super.key});
  Controller controller = Get.put(Controller());
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: homeTitleBar,
            color: lightColor,
            textSize: 20,
          ),
        ),
        body: NotesBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 21.0),
          child: FloatingActionButton(
              backgroundColor: Colors.grey,
              onPressed: () {
                Get.to(() => DialogWidget());
              },
              child: const Icon(Icons.add)),
        ),
      );
    });
  }
}
