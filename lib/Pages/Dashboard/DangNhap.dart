import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starbuck_clone/Object/user.dart';
import 'package:starbuck_clone/Pages/Dashboard/TrangChu.dart';

void main() {
  runApp(DangNhap());
}

class DangNhap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DangNhap();
}

class _DangNhap extends State<DangNhap> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> checkAcc(String name) async {
    QuerySnapshot document = await firestore
        .collection("User")
        .where("sUsername", isEqualTo: name)
        .get();

    if (document.docs.isNotEmpty) {
      print("Done");
      Provider.of<user>(context, listen: false)
          .setUsername(document.docs[0]['sUsername']);
    } else {
      print("Tài khoản không tồn tại");
    }
  }

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: ListView(
        children: [
          Center(
            child: Container(
              height: 200,
              width: 300,
              child: Image.asset("assets/images/logo.jpg"),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(0),
              child: const Text(
                "Starbucks Coffee",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(50),
              child: Form(
                key: formkey,
                child: Column(children: [
                  const Text(
                    "Đăng nhập",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  TextFormField(
                    controller: username,
                    decoration: const InputDecoration(
                        hintText: "Nhập tên nhân viên", labelText: "Username"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Nhập username";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: password,
                    decoration: const InputDecoration(
                        hintText: "Nhập password", labelText: "Password"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Nhập username";
                      }
                      if (value.length < 8) {
                        return "Password không đủ 8 kí tự";
                      }

                      return null;
                    },
                  ),
                  Checkbox(
                    value: true,
                    onChanged: (bool? value) {},
                  ),
                  const Text("Lưu thông tin mật khẩu"),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          print("123");
                          if (formkey.currentState!.validate()) {
                            print(username.text);
                            checkAcc(username.text);
                          }
                        });
                      },
                      child: const Text("Đăng nhập"))
                ]),
              )),
        ],
      ),
    );
  }
}
