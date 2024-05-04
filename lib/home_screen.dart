import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controller/global_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Column(
        children: [
          Obx(() => Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: globalController.redColor.value
                      ? Colors.red
                          .withOpacity(globalController.opacity.toDouble())
                      : Colors.purpleAccent
                          .withOpacity(globalController.opacity.toDouble())),
              child: Center(child: Text(globalController.counter.toString())))),
          const SizedBox(
            height: 20,
          ),
          Obx(() => Slider(
              value: globalController.opacity.toDouble(),
              onChanged: (value) {
                globalController.increaseOpacity(value);
              })),
          //SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Change color into Red:"),
                Obx(() => Switch(
                    value: globalController.redColor.value,
                    onChanged: (value) {
                      globalController.changeColor(value);
                    }))
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Obx(() =>
                CircleAvatar(radius: 40,
                  backgroundImage: globalController.imagePath.isNotEmpty ? FileImage(File(globalController.getImage().toString())) : null)),
                TextButton(onPressed: (){
                  globalController.getImage();
                }, child: const Text("Pick Image"))
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_task),
        onPressed: () {
          globalController.incrementCounter();
        },
      ),
    );
  }
}
