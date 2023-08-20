import 'package:flutter/material.dart';

import 'saveitems.dart';
import 'savenoexp.dart';

class AddItems extends StatefulWidget {
  const AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  @override
  Widget build(BuildContext context) {
    var widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 115, 13),
        title: Text(
          "รายการสินค้า",
          textScaleFactor: widthsize * 0.003,
        ),
        toolbarHeight: widthsize * 0.15,
        titleSpacing: widthsize * 0.08,
      ),
      body: Padding(
        padding: EdgeInsets.all(0.05 * widthsize),
        child: Column(
          children: [
            Text(
              "Type",
              style: TextStyle(fontSize: widthsize * 0.15,color: const Color.fromARGB(255, 89, 25, 100)),
            ),
            SizedBox(
              height: widthsize * 0.1,
            ),
            haveExp(widthsize),
            SizedBox(
              height: widthsize * 0.1,
            ),
            noExp(widthsize)
          ],
        ),
      ),
    );
  }

  Widget haveExp(widthsize) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: const Color.fromARGB(255, 96, 181, 35)),
        height: 0.2 * widthsize,
        padding: EdgeInsets.all(0.05 * widthsize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "มี EXP",
                  style: TextStyle(fontSize: 0.07 * widthsize),
                ),
                SizedBox(width: widthsize*0.02,),
                Icon(Icons.access_alarm, size: widthsize * 0.09)
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,MaterialPageRoute(
                      builder: ((context) => const SaveItems())));
                },
                icon: Icon(Icons.arrow_forward_ios, size: widthsize * 0.06))
          ],
        ),
      );

  Widget noExp(widthsize) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color:const Color.fromARGB(255, 96, 181, 35)),
        height: 0.2 * widthsize,
        padding: EdgeInsets.all(0.05 * widthsize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ไม่มี EXP",
                  style: TextStyle(fontSize: 0.07 * widthsize),
                ),
                SizedBox(width: widthsize*0.02,),
                Icon(Icons.alarm_off_outlined, size: widthsize * 0.09)
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,MaterialPageRoute(
                      builder: ((context) => const SaveNoEXP())));
                },
                icon: Icon(Icons.arrow_forward_ios, size: widthsize * 0.06))
          ],
        ),
      );
}
