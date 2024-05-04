import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class GlobalController extends GetxController {
  RxInt counter = 0.obs;
  RxDouble opacity = .0.obs;
  RxBool redColor = false.obs;

  RxList<String> fruitList =
      ['Apple', "Banana", "Orange", "Guava", "Mango"].obs;
  RxList favoriteFruit = [].obs;

  RxString imagePath = ''.obs;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  RxBool isLoading = false.obs;

  incrementCounter() {
    counter.value++;
  }

  increaseOpacity(double value) {
    opacity.value = value;
  }

  changeColor(bool value) {
    redColor.value = value;
  }

  addFavorite(String value) {
    favoriteFruit.add(value);
  }

  removeFavorite(String value) {
    favoriteFruit.remove(value);
  }

  Future getImage()async{
    final ImagePicker imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if(image != null){
      imagePath.value = image.path.toString();
    } else{
      imagePath.value = '';
    }
  }

  void loginCall() async{
    isLoading.value = true;
    final response = await post(Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
    body: {
      'email': emailController.value.text,
    'password': passwordController.value.text
    });

    var data = jsonDecode(response.body);
    if(response.statusCode == 200 || response.statusCode == 201){
      Get.snackbar("LogIn Success", "Good Work!");
      print(data.toString());
      isLoading.value = false;
    } else {
      Get.snackbar("LogIn Failed", response.statusCode.toString());
      print(data.toString());
      isLoading.value = false;
    }

  }
}
