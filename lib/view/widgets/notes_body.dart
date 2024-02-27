import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/consts/assets.dart';
import 'package:noteapp/controller/controller.dart';
import 'package:noteapp/view/components/custom_text.dart';
import 'package:noteapp/view/widgets/note_item.dart';

// ignore: must_be_immutable
class NotesBody extends StatelessWidget {
  NotesBody({
    super.key,
  });
  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.only(top: 12),
        margin: const EdgeInsets.only(top: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: controller.list.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(text: 'No data yet'),
                    const Image(image: AssetImage(Assets.imagesImages)),
                  ],
                ),
              )
            : Column(
                children: [
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: controller.list.length,
                        itemBuilder: ((context, index) {
                          return NoteItem(
                            controller: controller,
                            index: index,
                          );
                        })),
                  )
                ],
              ),
      );
    });
  }
}
