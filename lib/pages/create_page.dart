import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../services/rtdb_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var isLoading = false;
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var dateController = TextEditingController();
  var contentController = TextEditingController();

  _createPost() {
    String firstname = firstnameController.text.toString();
    String lastname = lastnameController.text.toString();
    String date = dateController.text.toString();
    String content = contentController.text.toString();

    if (firstname.isEmpty ||
        lastname.isEmpty ||
        date.isEmpty ||
        content.isEmpty) return;

    _apiCreatePost(firstname, lastname, date, content);
  }

  _apiCreatePost(
      String firstname, String lastname, String date, String content) {
    setState(() {
      isLoading = true;
    });
    var post = Post(
        firstname: firstname, lastname: lastname, date: date, content: content);
    RTDBService.addPost(post).then((value) => {
          _resAddPost(),
        });
  }

  _resAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': 'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add post for plans"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: firstnameController,
                  decoration: const InputDecoration(hintText: "Firstname"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: lastnameController,
                  decoration: const InputDecoration(hintText: "Lastname"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(hintText: "Date"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(hintText: "Content"),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                    onPressed: () {
                      _createPost();
                    },
                    color: Colors.purple,
                    child: const Center(
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
