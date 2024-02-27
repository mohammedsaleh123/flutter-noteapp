import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/controller/controller.dart';
import 'package:noteapp/view/components/custom_text.dart';
import 'package:noteapp/view/home_view.dart';

// ignore: must_be_immutable
class EditDialogWidget extends StatelessWidget {
  EditDialogWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.id,
      required this.titleController,
      required this.subTitleController,
      required this.color,
      required this.index});
  Controller controller = Get.find();
  final int id;
  final String title;
  final String subTitle;
  final TextEditingController titleController;
  final TextEditingController subTitleController;
  final int color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: controller.colors[controller.editColorsIndex],
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'Edit',
                color: Colors.black,
              ),
              const SizedBox(width: 4),
              const Icon(Icons.edit, color: Colors.black),
            ],
          ),
          leading: IconButton(
              onPressed: () {
                Get.offAll(() => HomeView());
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    fillColor: controller.colors[controller.editColorsIndex],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: subTitleController,
                  maxLines: null,
                  decoration: InputDecoration(
                    fillColor: controller.colors[controller.editColorsIndex],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    controller.isColorChange == true
                        ? controller.updateData(
                            id,
                            titleController.text,
                            subTitleController.text,
                            "updated at ${DateFormat('d_MMM_y  h:m a').format(
                              DateTime.now(),
                            )}",
                            controller.editColorsIndex)
                        : controller.updateData(
                            id,
                            titleController.text,
                            subTitleController.text,
                            "updated at ${DateFormat('d_MMM_y  h:m a').format(
                              DateTime.now(),
                            )}",
                            controller.list[index]['color'],
                          );
                    titleController.clear();
                    subTitleController.clear();
                    Get.back();
                  },
                  child: CustomText(text: 'Edit'),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.colors.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.changeEditColorsIndex(value: index);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: controller.colors[index],
                                border: Border.all(
                                    color: controller.editColorsIndex == index
                                        ? Colors.black
                                        : Colors.transparent,
                                    width: 2),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
