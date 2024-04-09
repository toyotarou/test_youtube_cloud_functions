import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firebase_helper.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key, required this.token});

  final String token;

  ///
  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  late final TextEditingController titleEditingController;
  late final TextEditingController bodyEditingController;
  late final ImagePicker _picker;

  ///
  @override
  void initState() {
    titleEditingController = TextEditingController();
    bodyEditingController = TextEditingController();
    _picker = ImagePicker();

    super.initState();
  }

  XFile? xFile;
  bool isLoading = false;
  String image = '';

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notification to device'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  key: UniqueKey(),
                  keyboardType: TextInputType.text,
                  controller: titleEditingController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) => titleEditingController.text = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  maxLines: 3,
                  key: UniqueKey(),
                  keyboardType: TextInputType.text,
                  controller: bodyEditingController,
                  decoration: InputDecoration(
                    labelText: 'Body',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) => bodyEditingController.text = value,
                ),
              ),
              InkWell(
                onTap: () async {
                  isLoading = true;
                  setState(() {});

                  xFile = await _picker.pickImage(source: ImageSource.gallery);

                  if (xFile != null) {
                    setState(() {});

                    final url = await FirebaseHelper.uploadImage(File(xFile!.path));

                    if (url != null) {
                      image = url;
                      isLoading = false;
                      setState(() {});
                      return;
                    }
                  }

                  isLoading = false;
                  setState(() {});
                },
                child: Container(
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(width: 8, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                    image: xFile?.path != null
                        ? DecorationImage(
                            image: FileImage(File(xFile!.path)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: xFile?.path != null ? null : const Center(child: Icon(Icons.photo)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          FirebaseHelper.sendNotification(
                              title: titleEditingController.text, body: bodyEditingController.text, token: widget.token, image: image);
                        },
                        child: const Text('Send Notifications'),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
