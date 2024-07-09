import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailHistory extends StatelessWidget {
  const DetailHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat.decimalPattern();
    final bill = ModalRoute.of(context)!.settings.arguments as Map;

    var date = bill["dThoiGianLap"].toString().split(" ");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết hoá đơn"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.green[700],
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(date[1]),
                      Text(date[0]),
                    ],
                  ),
                )),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey, width: 1),
                    bottom: BorderSide(color: Colors.grey, width: 1)),
              ),
              child: Text(
                "Bàn ${bill['MaBan']} | Tổng: ${formatter.format(bill['fThanhTien'])} Đ",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
