import 'package:flutter/material.dart';

class AddManRequestPage extends StatefulWidget {
  const AddManRequestPage({super.key});

  @override
  State<AddManRequestPage> createState() => _AddManRequestPageState();
}

class _AddManRequestPageState extends State<AddManRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Manufacture Request'),
      ),
      body: const Center(
        child: Hero(tag: 'addFAB', child: Icon(Icons.save)),
      ),
    );
  }
}
