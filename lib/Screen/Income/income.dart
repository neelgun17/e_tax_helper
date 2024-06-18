import 'package:e_tax_helper/Model/user_data.dart';
import 'package:flutter/material.dart';

class IncomeInformationPage extends StatefulWidget {
  final UserData userData;
  const IncomeInformationPage({Key? key, required this.userData}) : super(key: key);

  @override
  _IncomeInformationPageState createState() => _IncomeInformationPageState();
}

class _IncomeInformationPageState extends State<IncomeInformationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _annualSalaryController = TextEditingController();
  final TextEditingController _monthlyRentController = TextEditingController();

  @override
  void dispose() {
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
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _annualSalaryController,
                decoration: const InputDecoration(labelText: 'What is your annual salary?'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your annual salary';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _monthlyRentController,
                decoration: const InputDecoration(labelText: 'What is your monthly rent/mortgage?'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your monthly rent/mortgage';
                  }
                  return null;
                },
              ),
              // Add more questions as needed
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            setState(() {
              widget.userData.annualSalary = double.tryParse(_annualSalaryController.text) ?? 0.0;
              widget.userData.monthlyRent = double.tryParse(_monthlyRentController.text) ?? 0.0;

              // Calculate taxes
              widget.userData.owedInTaxes = widget.userData.changeNumber(widget.userData);

              // Update other tax related fields
              // For example:
              // widget.userData.stateIncomeTax = ...

              // Notify the rest of the app
              widget.userData.updateData();
            });

            // Optionally show a snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Data saved. Tax owed: ${widget.userData.owedInTaxes}"),
              ),
            );
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}