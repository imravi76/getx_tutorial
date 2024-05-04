
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/home_screen.dart';

import 'controller/global_controller.dart';
import 'fruit_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Main"),
          leading: IconButton(
            onPressed: () {
              Get.defaultDialog(
                  title: "Change Theme",
                  middleText:
                      "Do you want change theme into ${Get.isDarkMode ? "Light Mode?" : "Dark Mode?"}",
                  textConfirm: "Yes",
                  textCancel: "No",
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    Get.changeTheme(
                        Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                    Get.back();
                    Get.snackbar("Theme Changed",
                        "Theme changed into ${Get.isDarkMode ? "Light Mode" : "Dark Mode"}",
                        colorText:
                            Get.isDarkMode ? Colors.black : Colors.white);
                  });
            },
            icon: Icon(Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nights_stay_outlined),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.to(const HomeScreen());
          },
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Card(
                  child: ListTile(
                title: const Text("Fruit Lists"),
                subtitle: const Text("Click me for details"),
                onTap: () {
                  Get.bottomSheet(Container(
                    padding: const EdgeInsets.only(left: 65, top: 50, right: 65, bottom: 80),
                    child: TextButton(child: const Text("Click on ME to go to Fruit Screen!"), onPressed: () {
                      Get.to(const FruitScreen());
                    }),
                  ));
                },
              )
              ),
              TextField(controller: globalController.emailController.value, decoration: const InputDecoration(hintText: 'Email'),),
              TextField(obscureText: true, controller: globalController.passwordController.value, decoration: const InputDecoration(hintText: 'Password'),),
              const SizedBox(height: 20,),
              Obx(() =>
              InkWell(
                onTap: (){
                  globalController.loginCall();
                },
                child: Container(
                  height: 40,
                  color: Colors.purpleAccent,
                  child: Center(
                    child: globalController.isLoading.value ? const CircularProgressIndicator() : const Text("Submit", style: TextStyle(color: Colors.white),),
                  ),
                ),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}
