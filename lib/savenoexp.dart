import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'boxes.dart';
import 'navigation.dart';
import 'person.dart';

class SaveNoEXP extends StatefulWidget {
  const SaveNoEXP({super.key});

  @override
  State<SaveNoEXP> createState() => _SaveNoEXPState();
}

class _SaveNoEXPState extends State<SaveNoEXP> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final expController = TextEditingController();
  final _formatter = DateFormat('dd/MM/yyyy');

  final amountController = TextEditingController();
  late String bit;
  File? file;
  ImagePicker image = ImagePicker();
  getImage() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.gallery);
    if (img?.path != null) {
      setState(() {
        file = File(img!.path);
      });
      bit = base64.encode(await file!.readAsBytes());
    }
  }

  @override
  void dispose() {
    expController.dispose();
    super.dispose();
  }


  bool _validateDate() {
    try {
       _formatter.parse(expController.text);
      return false;
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 115, 13),
        title: Text(
          "เพิ่มสินค้า",
          textScaleFactor: widthsize * 0.003,
        ),
        toolbarHeight: widthsize * 0.15,
        titleSpacing: widthsize * 0.08,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0.05 * widthsize),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                imageHere(widthsize),
                iconPickPicture(widthsize),
                textfieldName(widthsize),
                textFiealdExp(widthsize),
                textFiealdAmount(widthsize),
                SizedBox(height: widthsize * 0.04),
                btnSave(widthsize)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageHere(widthsize) => SizedBox(
        height: widthsize * 0.5,
        width: widthsize * 0.5,
        child: file == null
            ? Icon(
                Icons.image,
                size: widthsize * 0.5,
              )
            : Image.file(
                file!,
                fit: BoxFit.fill,
              ),
      );

  Widget iconPickPicture(widthsize) => IconButton(
      onPressed: () {
        getImage();
      },
      icon: Icon(
        Icons.photo_album_outlined,
        size: 0.05 * widthsize,
      ));

  Widget textfieldName(widthsize) => SizedBox(
        height: 0.2 * widthsize,
        child: TextFormField(
          decoration: const InputDecoration(labelText: "ชื่อรายการ"),
          style: TextStyle(fontSize: 0.05 * widthsize),
          // keyboardType: TextInputType.number,
          controller: nameController,
          validator: (str) {
            //str คือตัวแปร string
            if (str!.isEmpty) {
              return "กรุณากรอกข้อความ";
            }
            return null;
          },
        ),
      );

  Widget textFiealdExp(widthsize) => SizedBox(
        height: 0.2 * widthsize,
        child: TextFormField(
          decoration: const InputDecoration(labelText: "วันหมดอายุ dd/mm/yyyy"),
          style: TextStyle(fontSize: 0.05 * widthsize),
          // keyboardType: TextInputType.number,
          controller: expController,
          keyboardType: TextInputType.number,
          validator: (str) {
            //str คือตัวแปร string
            if (str!.isEmpty) {
              return "กรุณากรอกข้อความ";
            } else if (_validateDate()) {
              return "กรุณากรอกใหม่ให้ถูกต้อง";
            } else {
              return null;
            }
          },
        ),
      );

  Widget textFiealdAmount(widthsize) => SizedBox(
        height: 0.3 * widthsize,
        child: TextFormField(
          decoration: const InputDecoration(labelText: "จำนวน"),
          style: TextStyle(fontSize: 0.05 * widthsize),
          // keyboardType: TextInputType.number,
          controller: amountController,
          keyboardType: TextInputType.number,
          validator: (str) {
            //str คือตัวแปร string
            if (str!.isEmpty) {
              return "กรุณากรอกข้อความ";
            }
            return null;
          },
        ),
      );

  Widget btnSave(widthsize) => SizedBox(
        height: widthsize * 0.1,
        width: widthsize * 0.3,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            if ((formKey.currentState!.validate() && file != null)) {
              setState(() {
                boxPersons.put(
                    'key_$nameController',
                    Person(
                        name: nameController.text,
                        exp: expController.text,
                        picture: bit,
                        amount: int.parse(amountController.text),
                        type: "noexp"));
              });
              Navigator.pushReplacement(context,MaterialPageRoute(
                      builder: ((context) => const Testnavigation())));
            }
          },
          child: const Text(
            'เพิ่มข้อมูล',
            textScaleFactor: 2,
          ),
        ),
      );
}