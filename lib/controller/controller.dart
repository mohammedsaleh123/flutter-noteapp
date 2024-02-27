import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/consts/text_const.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Controller extends GetxController {
  List<Map> list = [];
  TextEditingController titleEdit = TextEditingController();
  TextEditingController subTitleEdit = TextEditingController();
  List<Color> colors = [
    Colors.grey.shade200,
    Colors.orange.shade200,
    Colors.red.shade200,
    Colors.blue.shade200,
    Colors.green.shade200,
  ];
  int addColorsIndex = 0;
  int editColorsIndex = 0;
  bool isColorChange = false;
  double width = 50;
  double height = 50;

  @override
  void onInit() {
    super.onInit();
    createDataBase();
    getData();
  }

  createDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseTableName);

    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Notes (id INTEGER PRIMARY KEY, title TEXT,subTitle TEXT,time Text,color INTEGER)');
    });
  }

  insertData(String title, String subTitle, String time, int color) async {
    var db = await openDatabase(databaseTableName);

    await db.rawInsert(
        'INSERT INTO Notes(title,subTitle,time,color) VALUES(?,?,?,?)',
        [title, subTitle, time, color]);
    isColorChange = false;
    getData();
    update();
    db.close();
  }

  updateData(
      int id, String title, String subTitle, String time, int color) async {
    var db = await openDatabase(databaseTableName);
    final data = {
      'title': title,
      'subTitle': subTitle,
      'time': time,
      'color': color,
    };
    await db.update('Notes', data, where: 'id = ?', whereArgs: [id]);
    isColorChange = false;
    update();
    getData();
    db.close();
  }

  getData() async {
    var db = await openDatabase(databaseTableName);
    await db.rawQuery('SELECT * FROM Notes').then((value) => list = value);
    isColorChange = false;
    update();
    db.close();
  }

  deleteData(int id) async {
    var db = await openDatabase(databaseTableName);
    await db.rawDelete('DELETE FROM Notes WHERE id = ?', [id]);
    isColorChange = false;
    update();
    getData();
    db.close();
  }

  textToUpdate(titleText, subTitleText) {
    titleEdit.text = titleText;
    subTitleEdit.text = subTitleText;
    update();
    getData();
  }

  changeAddColorsIndex({value = 0}) {
    colors[value];
    addColorsIndex = value;
    isColorChange = false;
    update();
  }

  changeEditColorsIndex({value = 0}) {
    colors[value];
    editColorsIndex = value;
    isColorChange = true;
    update();
  }

  Color changeBorderAddColor(int index, Color color) {
    if (colors[index] == colors[addColorsIndex]) {
      return color;
    }
    return Colors.transparent;
  }

  changeBorderEditColor(int index) {
    colors[index] == colors[editColorsIndex];
    update();
  }
}
