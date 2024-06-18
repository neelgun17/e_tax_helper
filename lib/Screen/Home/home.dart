import 'package:flutter/material.dart';
import 'package:e_tax_helper/Model/user_data.dart';

import 'Widgets/summary.dart';

class HomePage extends StatefulWidget {
  final UserData userData;

  const HomePage({Key? key, required this.userData}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.userData.onDataChanged = () {
      setState(() {}); // This will rebuild HomePage with updated userData
    };
  }

  @override
  void dispose() {
    widget.userData.onDataChanged = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: Summary(userData: widget.userData), // Pass userData to Summary
    );
  }
}