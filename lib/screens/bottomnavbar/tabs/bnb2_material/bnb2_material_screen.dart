import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb2_material/bnb2_material_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb2_material/bnb2_material_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bnb2MaterialScreen extends StatelessWidget with Bnb2MaterialWidgets {
  Bnb2MaterialScreen({super.key});

  final Bnb2MaterialController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text("hhhh")]));
  }
}
