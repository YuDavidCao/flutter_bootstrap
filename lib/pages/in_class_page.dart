import 'package:flutter/material.dart';

class InClassPage extends StatefulWidget {
  final String classId;
  const InClassPage({super.key, required this.classId});

  @override
  State<InClassPage> createState() => _InClassPageState();
}

class _InClassPageState extends State<InClassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
