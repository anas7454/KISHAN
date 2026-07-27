import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb5_myprofile/bnb5_myprofile_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb5_myprofile/bnb5_myprofile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bnb5MyProfileScreen extends StatelessWidget with Bnb5MyProfileWidgets {
  Bnb5MyProfileScreen({super.key});

  final Bnb5MyProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: []));
  }
}
