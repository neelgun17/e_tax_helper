import 'package:e_tax_helper/Model/user_data.dart';
import 'package:flutter/material.dart';

class IncomeInformationPage extends StatefulWidget {
  final UserData userData;
  const IncomeInformationPage({Key? key, required this.userData}) : super(key: key);

  @override
  _IncomeInformationPageState createState() => _IncomeInformationPageState();
}

class _IncomeInformationPageState extends State<IncomeInformationPage> {
  late TextEditingController _annualSalaryController;
  late TextEditingController _monthlyRentController;

  @override
  void initState() {
    super.initState();
    _annualSalaryController = TextEditingController(text: widget.userData.annualSalary.toString());
    _monthlyRentController = TextEditingController(text: widget.userData.monthlyRent.toString());

    _annualSalaryController.addListener(_saveData);
    _monthlyRentController.addListener(_saveData);
  }

  void _saveData() {
    setState(() {
      widget.userData.annualSalary = double.tryParse(_annualSalaryController.text) ?? 0.0;
      widget.userData.monthlyRent = double.tryParse(_monthlyRentController.text) ?? 0.0;
      widget.userData.owedInTaxes = widget.userData.changeNumber(widget.userData);
      widget.userData.updateData();
    });
  }

  @override
  void dispose() {
    _annualSalaryController.removeListener(_saveData);
    _monthlyRentController.removeListener(_saveData);
    _annualSalaryController.dispose();
    _monthlyRentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Income Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _annualSalaryController,
                decoration: const InputDecoration(labelText: 'What is your annual salary?'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _monthlyRentController,
                decoration: const InputDecoration(labelText: 'What is your monthly rent/mortgage?'),
                keyboardType: TextInputType.number,
              ),
              // Add more questions as needed
            ],
          ),
        ),
      ),
    );
  }
}