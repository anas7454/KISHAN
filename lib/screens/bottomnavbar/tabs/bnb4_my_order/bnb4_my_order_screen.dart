import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb4_my_order/bnb4_my_order_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb4_my_order/bnb4_my_order_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bnb4MyOrderScreen extends StatelessWidget with Bnb4MyOrderWidgets {
  Bnb4MyOrderScreen({super.key});

  final Bnb4MyOrderController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: []));
  }
}
