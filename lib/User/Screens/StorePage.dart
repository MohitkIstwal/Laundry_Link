import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});
  @override
  State<StorePage> createState() => _StorePageState();

}

class _StorePageState extends State<StorePage> {

  @override
  Widget build(BuildContext context) {

  final storeName = ModalRoute.of(context)?.settings.arguments as String?;

  return Scaffold(
      appBar: AppBar(
        title : Text(storeName!),
      ),
    );
  }
}
