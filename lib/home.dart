import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'additems.dart';
import 'boxes.dart';
import 'person.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _StokState();
}

class _StokState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  int _idx = 0;
  final _tgbSelected = <bool>[true, false, false]; //togglebutton
  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd/MM/yyyy');
    List<Person> sortedPersons = boxPersons.values.toList().cast<Person>();
    sortedPersons.sort((a, b) {
      final aDate = DateFormat('dd/MM/yyyy').parse(a.exp);
      final bDate = DateFormat('dd/MM/yyyy').parse(b.exp);
      final aDifference = aDate.difference(DateTime.now()).inDays;
      final bDifference = bDate.difference(DateTime.now()).inDays;
      return aDifference.compareTo(bDifference);
    }); //เรียงลำดับตามวันหมดอายุ

    var widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 4, 115, 13),
          title: Text(
            "รายการสินค้าที่ไม่มี EXP",
            textScaleFactor: widthsize * 0.003,
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: widthsize * 0.06),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  size: widthsize * 0.08,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const AddItems())));
                },
              ),
            )
          ],
          toolbarHeight: widthsize * 0.15,
          titleSpacing: widthsize * 0.08,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                toggleButton(),
                ListView.builder(
                    physics: const ScrollPhysics(parent: null),
                    shrinkWrap: true,
                    itemCount: sortedPersons.length, //boxPersons.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      // Person person = boxPersons.getAt(index);
                      Person person = sortedPersons[index]; //เรียง

                      final now = DateTime.now();
                      final inputDate = formatter
                          .parse(person.exp.toString()); //แปลงเป็นวันที่
                      final difference = inputDate
                          .difference(now)
                          .inDays; //ระยะห่างกับวันหมดอายุ
                      if (person.type == "exp") {
                        return const SizedBox.shrink();
                      }
                      if (_tgbSelected[0] && difference > -1) {
                        return const SizedBox.shrink();
                      } else if (_tgbSelected[1] &&
                          (difference < 0 || difference > 1)) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color.fromARGB(255, 96, 181, 35)),
                        margin: const EdgeInsets.all(10),
                        child: ExpansionTile(
                            title: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(widthsize * 0.015),
                                  width: widthsize * 0.2,
                                  height: widthsize *
                                      0.2, // ให้สูงถึงขอบล่างของ ListTile
                                  child: image(person.picture),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ชื่อ ${person.name}",
                                        style: textStyle()),
                                    Text(
                                      "จำนวน${person.amount}\nจะหมดอายุใน $difference วัน",
                                      style: textStyle(),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            showEditDialog(
                                                context, person, widthsize);
                                          },
                                          icon: const Icon(Icons.edit),
                                          color: Colors.white,
                                          iconSize: 60,
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                            children: [
                              buildButtons(context, person.exp, index),
                            ]),
                      );
                    }),
              ],
            ),
          ),
        ));
  }

  TextStyle textStyle() => const TextStyle(color: Colors.white, fontSize: 40);
  TextStyle textStyle2(Color color) =>
      TextStyle(color: color, fontSize: 30, fontWeight: FontWeight.bold);
  TextStyle textStyle3(Color color) => TextStyle(color: color, fontSize: 30);

  Widget image(String thumbnail) {
    String placeholder =
        "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==";
    if (thumbnail.isEmpty) {
      thumbnail = placeholder;
    } else {
      if (thumbnail.length % 4 > 0) {
        thumbnail +=
            '=' * (4 - thumbnail.length % 4); // as suggested by Albert221
      }
    }
    final byteImage = const Base64Decoder().convert(thumbnail);
    return Image.memory(
      byteImage,
      fit: BoxFit.cover,
    );
  }

  Widget toggleButton() => ToggleButtons(
          isSelected: _tgbSelected,
          borderRadius: BorderRadius.circular(10),
          borderColor: Colors.red,
          selectedBorderColor: Colors.red,
          selectedColor: Colors.white,
          color: Colors.blue,
          fillColor: Colors.grey,
          borderWidth: 5,
          onPressed: (index) => setState(() {
                _tgbSelected[index] = true;
                _tgbSelected[_idx] = false;
                _idx = index;
              }),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'หมดอายุ',
                style: textStyle2(Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'เหลือ 1 วัน',
                style: textStyle2(Colors.amber),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('ทั้งหมด',
                  style: textStyle2(const Color.fromARGB(255, 13, 218, 20))),
            )
          ]);

  Widget buildButtons(BuildContext context, exp, index) => Container(
        color: Colors.red,
        child: Row(
          children: [
            Expanded(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "EXP$exp",
                  style: textStyle(),
                ),
              )),
            ),
            Expanded(
              child: TextButton.icon(
                  label: Text(
                    'Delete',
                    style: textStyle(),
                  ),
                  icon: const Icon(
                    Icons.delete,
                    size: 50,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      boxPersons.deleteAt(index);
                    });
                  }),
            )
          ],
        ),
      );
  final _formatter = DateFormat('dd/MM/yyyy');
  void showEditDialog(BuildContext context, Person person, widthsize) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = person.name;
        int newAmount = person.amount;
        String newExp = person.exp;

        return AlertDialog(
          title: Text(
            'แก้ไขรายการสินค้า',
            style: TextStyle(fontSize: widthsize * 0.06),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: textStyle3(Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'ชื่อ',
                  ),
                  onChanged: (value) {
                    newName = value;
                  },
                ),
                TextField(
                  style: textStyle3(Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'จำนวน',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    newAmount = int.tryParse(value) ?? person.amount;
                  },
                ),
                TextFormField(
                  style: textStyle3(Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'วันหมดอายุ dd/MM/YYYY',
                  ),
                  validator: (str) {
                    if (str!.isEmpty) {
                      return null;
                    } else if (_validateDate(str)) {
                      return "กรุณากรอกใหม่ให้ถูกต้อง";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _formatter.parse(value);
                    newExp = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('บันทึก'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    person.name = newName;
                    person.amount = newAmount;
                    person.exp = newExp;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  bool _validateDate(value) {
    try {
      _formatter.parse(value);
      return false;
    } catch (e) {
      return true;
    }
  }
}
