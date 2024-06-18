//   import 'package:flutter/material.dart';

// import '../../../Model/user_data.dart';

// Widget _buildSaveButton(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();
//   final numberOfDependentsController = TextEditingController();
//   final ageController = TextEditingController();
//     final UserData userData;

//     return FloatingActionButton(

//       onPressed: () {
//         if (_formKey.currentState!.validate()) {
//           // Parse the values from the controllers
//           int dependents = int.tryParse(numberOfDependentsController.text) ?? 0;
//           int age = int.tryParse(ageController.text) ?? 0;

//           // Update userData with these values
//           widget.userData.dependents = dependents;
//           widget.userData.age = age;
//           widget.userData.updateData();

//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Dependents: $dependents, Age: $age, State: ${widget.userData.state}")),
//           );
//         }
//       },
//         child: const Icon(Icons.save),
//     );
//   }