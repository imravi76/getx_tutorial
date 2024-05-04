import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/global_controller.dart';

class FruitScreen extends StatefulWidget {
  const FruitScreen({super.key});

  @override
  State<FruitScreen> createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen> {
  final GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fruit Screen"),
      ),
      body: ListView.builder(
          itemCount: globalController.fruitList.length,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
              title: Text(globalController.fruitList[index].toString()),
              trailing: Obx(() => IconButton(
                    icon: Icon(
                      globalController.favoriteFruit.contains(
                              globalController.fruitList[index].toString())
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: globalController.favoriteFruit.contains(
                              globalController.fruitList[index].toString())
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () {
                      globalController.favoriteFruit.contains(
                              globalController.fruitList[index].toString())
                          ? globalController.removeFavorite(
                              globalController.fruitList[index].toString())
                          : globalController.addFavorite(
                              globalController.fruitList[index].toString());
                    },
                  )),
            ));
          }),
    );
  }
}
