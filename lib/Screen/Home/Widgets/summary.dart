import 'package:flutter/material.dart';
import 'package:e_tax_helper/Model/user_data.dart';

class Summary extends StatelessWidget {
  final UserData userData;

  const Summary({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildBackground(context),
            Expanded(
              child: buildBreakdown(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBackground(BuildContext context) => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            width: double.infinity,
            height: 150,
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0xFFD3D3D3),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Amount owed in Taxes',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Text(
                  userData.changeNumber(userData).toStringAsFixed(2),
                  style: const TextStyle(color: Colors.black, fontSize: 38),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Potential ways to save',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 14),
                    ),
                    IconButton(
                      icon: const Icon(Icons.info_outline),
                      color: Colors.black,
                      iconSize: 15,
                      tooltip: 'Detailed ways to save',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('How to Save'),
                              content: const Text('Here are some detailed ways to save on your taxes...'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildBreakdown() => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            height: 800,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFD3D3D3),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Breakdown',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  _buildSection("Federal income tax", "\$${userData.changeNumber(userData).toStringAsFixed(2)}"),
                  const Divider(),
                  _buildSection("State income tax", "\$${userData.calculateStateTax(userData).toStringAsFixed(2)}"), // Replace with actual calculations
                  const Divider(),
                  _buildSection("Social Security tax", "\$200.00"), // Replace with actual calculations
                  const Divider(),
                  _buildSection("Medicare tax", "\$100.00"), // Replace with actual calculations
                  const Divider(),
                  _buildSection("Total taxes owed", "\$${userData.owedInTaxes.toStringAsFixed(2)}"),
                  const Divider(),
                  _buildSection("Income after Taxes", "\$1000.00"), // Replace with actual calculations
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildSection(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            amount,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}