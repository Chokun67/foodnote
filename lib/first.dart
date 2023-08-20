import 'package:flutter/material.dart';
import 'package:foodnote/person.dart';
import 'package:foodnote/scanqr.dart';
import 'package:intl/intl.dart';
import 'additems.dart';
import 'boxes.dart';
import 'navigation.dart';
import 'notification.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    final formatter = DateFormat('dd/MM/yyyy');
    List<String> name = [];
    List<Person> sortedPersonsNoti = boxPersons.values
        .toList()
        .cast<Person>(); // สร้างสำเนาของอาเรย์เพื่อป้องกันการเปลี่ยนแปลงต้นฉบับ
    sortedPersonsNoti
        .sort((a, b) => a.exp.compareTo(b.exp)); // เรียงลำดับตามวันหมดอายุ

    for (int index = 0; index < sortedPersonsNoti.length; index++) {
      Person person = sortedPersonsNoti[index];

      final now = DateTime.now();
      final inputDate = formatter.parse(person.exp.toString());

      if (now.year == inputDate.year &&
          now.month == inputDate.month &&
          now.day == inputDate.day) {
        name.add(person.name);
      }
      NotificationAlert().showNotification(
          "แจ้งเตือนหมดอายุ", "${name.join(', ')} จะหมดอายุภายในวันนี้");
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightsize = MediaQuery.of(context).size.height;
    var widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: widthsize * 0.05),
          child: Icon(Icons.home, size: widthsize * 0.09),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 115, 13),
        title: Text(
          "หน้าแรก",
          textScaleFactor: widthsize * 0.003,
        ),
        toolbarHeight: widthsize * 0.15,
        titleSpacing: widthsize * 0.08,
      ),
      body: Padding(
        padding: EdgeInsets.all(0.05 * widthsize),
        child: Column(
          children: [
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                height: heightsize * 0.3,
                width: widthsize * 0.5,
                child: Image.asset('images/foodnote2.jpg')),
            SizedBox(
              height: heightsize * 0.05,
            ),
            lookStock(widthsize),
            SizedBox(
              height: heightsize * 0.02,
            ),
            noExp(widthsize),
            SizedBox(
              height: heightsize * 0.02,
            ),
            scanQR(widthsize)
          ],
        ),
      ),
    );
  }

  Widget lookStock(widthsize) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 96, 181, 35)),
        height: 0.2 * widthsize,
        padding: EdgeInsets.all(0.05 * widthsize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ดูรายการสินค้า",
                  style: TextStyle(fontSize: 0.07 * widthsize),
                ),
                SizedBox(width: widthsize * 0.01),
                Icon(Icons.article_outlined, size: widthsize * 0.1)
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const Testnavigation())));
                },
                icon: Icon(Icons.arrow_forward_ios, size: widthsize * 0.06))
          ],
        ),
      );

  Widget noExp(widthsize) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 96, 181, 35)),
        height: 0.2 * widthsize,
        padding: EdgeInsets.all(0.05 * widthsize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "เพิ่มสินค้า",
                  style: TextStyle(fontSize: 0.07 * widthsize),
                ),
                SizedBox(width: widthsize * 0.01),
                Icon(Icons.add_business_outlined, size: widthsize * 0.1)
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AddItems())));
                },
                icon: Icon(Icons.arrow_forward_ios, size: widthsize * 0.06))
          ],
        ),
      );

  Widget scanQR(widthsize) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 96, 181, 35)),
        height: 0.2 * widthsize,
        padding: EdgeInsets.all(0.05 * widthsize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "สแกนข้อมูลสินค้า",
                  style: TextStyle(fontSize: 0.07 * widthsize),
                ),
                SizedBox(width: widthsize * 0.01),
                Icon(Icons.qr_code, size: widthsize * 0.1)
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const ScanQr())));
                },
                icon: Icon(Icons.arrow_forward_ios, size: widthsize * 0.06))
          ],
        ),
      );
}
