import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/consts/assets.dart';
import 'package:noteapp/consts/color_const.dart';
import 'package:noteapp/controller/controller.dart';
import 'package:noteapp/view/components/custom_text.dart';
import 'package:noteapp/view/widgets/edit_dialog_widget.dart';

// ignore: must_be_immutable
class NoteItem extends StatelessWidget {
  NoteItem({
    super.key,
    required this.controller,
    required this.index,
  });

  Controller controller = Get.find();
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      return Container(
        clipBehavior: Clip.none,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: controller.colors[controller.list[index]['color']],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 2,
            color: primaryColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          Assets.imagesIcon,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomText(
                      text: controller.list[index]['title'],
                      textSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(() => EditDialogWidget(
                          id: controller.list[index]['id'],
                          title: controller.list[index]['title'],
                          subTitle: controller.list[index]['subTitle'],
                          titleController: controller.titleEdit,
                          subTitleController: controller.subTitleEdit,
                          color: controller.list[index]['color'],
                          index: index,
                        ));
                    controller.editColorsIndex =
                        controller.list[index]['color'];

                    controller.textToUpdate(controller.list[index]['title'],
                        controller.list[index]['subTitle']);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.deleteData(
                      controller.list[index]['id'],
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            CustomText(
              text: controller.list[index]['time'],
              textSize: 14,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: CustomText(
                text: controller.list[index]['subTitle'],
                maxLines: 2,
                textOverflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      );
    });
  }
}
