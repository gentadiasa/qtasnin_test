import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_app/controllers/binding/initial_binding.dart';
import 'screens/item_screen.dart';
import 'screens/transaction_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sales App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: InitialBinding(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.to(() => ItemScreen());
              },
              child: Text('Manage Items'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => TransactionScreen());
              },
              child: Text('Manage Transactions'),
            ),
          ],
        ),
      ),
    );
  }
}