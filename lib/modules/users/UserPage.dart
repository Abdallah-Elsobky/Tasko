import 'package:flutter/material.dart';

import 'package:tasko/models/user.dart';


class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var ContactController = TextEditingController();
  List<UserModel> users = [
    UserModel(id: 1, name: "Abdallah", phone: "01226022955"),
    UserModel(),
    UserModel(id: 2, name: "Ahmed", phone: "01203203450"),
    UserModel(id: 3, name: "Tarek", phone: "01224535656"),
    UserModel(id: 4, name: "Mohamed", phone: "01226022955"),
    UserModel(id: 5, name: "Youssef", phone: "01226022955"),
    UserModel(id: 6, name: "Omar", phone: "01226022955"),
    UserModel(id: 7, name: "Ziad", phone: "01226022955"),
    UserModel(id: 8, name: "Asmaa", phone: "01226022955"),
    UserModel(id: 1, name: "Abdallah", phone: "01226022955"),
    UserModel(id: 2, name: "Ahmed", phone: "01203203450"),
    UserModel(id: 3, name: "Tarek", phone: "01224535656"),
    UserModel(id: 4, name: "Mohamed", phone: "01226022955"),
    UserModel(id: 5, name: "Youssef", phone: "01226022955"),
    UserModel(id: 6, name: "Omar", phone: "01226022955"),
    UserModel(id: 7, name: "Ziad", phone: "01226022955"),
    UserModel(id: 8, name: "Asmaa", phone: "01226022955"),
    UserModel(id: 1, name: "Abdallah", phone: "01226022955"),
    UserModel(id: 2, name: "Ahmed", phone: "01203203450"),
    UserModel(id: 3, name: "Tarek", phone: "01224535656"),
    UserModel(id: 4, name: "Mohamed", phone: "01226022955"),
    UserModel(id: 5, name: "Youssef", phone: "01226022955"),
    UserModel(id: 6, name: "Omar", phone: "01226022955"),
    UserModel(id: 7, name: "Ziad", phone: "01226022955"),
    UserModel(id: 8, name: "Asmaa", phone: "01226022955"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.supervised_user_circle_sharp),
        title: Text("Users"),
        backgroundColor: Colors.teal,
        actions: [BackButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildContactItem(users[index]),
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  itemCount: users.length,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: ContactController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        users.add(UserModel(
                            name: ContactController.text,
                            phone: "123456789")
                        );
                        ContactController.clear();
                      });
                    },
                    icon: Icon(Icons.add_call)),
                hintText: "Add Contact",
                filled: true,
                fillColor: Colors.black12,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildContactItem(UserModel user) => Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage("assets/programmer.png"),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.phone!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
      ],
    );
