import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/last_read_controller.dart';

class LastReadView extends GetView<LastReadController> {
  const LastReadView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LastReadView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LastReadView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
