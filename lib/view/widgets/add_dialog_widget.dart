import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/controller/controller.dart';
import 'package:noteapp/view/components/custom_text.dart';
import 'package:noteapp/view/home_view.dart';

// ignore: must_be_immutable
class DialogWidget extends StatelessWidget {
  DialogWidget({super.key});
  Controller controller = Get.find();
  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: controller.colors[controller.addColorsIndex],
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'Add',
                color: Colors.black,
              ),
              const SizedBox(width: 4),
              const Icon(Icons.add, color: Colors.black),
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
                  controller: title,
                  decoration: InputDecoration(
                    fillColor: controller.colors[controller.addColorsIndex],
                    filled: true,
                    hintText: 'title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: subTitle,
                  maxLines: 10,
                  decoration: InputDecoration(
                    fillColor: controller.colors[controller.addColorsIndex],
                    filled: true,
                    hintText: 'content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (title.text.isEmpty && subTitle.text.isEmpty) {
                          Get.snackbar('', '',
                              duration: const Duration(seconds: 4),
                              backgroundColor: Colors.white,
                              titleText: CustomText(
                                text: 'title and Subtitle is required',
                                textSize: 20,
                              ));
                        } else {
                          controller.insertData(
                              title.text,
                              subTitle.text,
                              'created at ${DateFormat('d_MMM_y  h:m a').format(
                                DateTime.now(),
                              )}',
                              controller.addColorsIndex);
                          title.clear();
                          subTitle.clear();
                          Get.back();
                        }
                      },
                      child: CustomText(text: 'Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisSize: MainAxisSize.min,
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
                              controller.changeAddColorsIndex(value: index);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              height: 50,
                              width: controller.width,
                              decoration: BoxDecoration(
                                color: controller.colors[index],
                                border: Border.all(
                                    color: controller.changeBorderAddColor(
                                        index, Colors.black),
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
