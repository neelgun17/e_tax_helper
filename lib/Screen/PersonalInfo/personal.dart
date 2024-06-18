import 'package:e_tax_helper/Model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalPage extends StatefulWidget {
  final UserData userData;

  const PersonalPage({Key? key, required this.userData}) : super(key: key);

  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<PersonalPage> {
  final _formKey = GlobalKey<FormState>();
  final numberOfDependentsController = TextEditingController();
  final ageController = TextEditingController();
  final List<String> _usStates = [
    "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", 
    "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", 
    "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", 
    "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", 
    "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", 
    "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", 
    "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", 
    "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", 
    "Washington", "West Virginia", "Wisconsin", "Wyoming"
  ];
  String? _selectedState;

  @override
  void initState() {
    super.initState();
    _loadData();

    numberOfDependentsController.addListener(_saveData);
    ageController.addListener(_saveData);
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      numberOfDependentsController.text = widget.userData.dependents.toString();
      ageController.text = widget.userData.age.toString();
      _selectedState = widget.userData.state;
    });
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.userData.dependents = int.tryParse(numberOfDependentsController.text) ?? 0;
      widget.userData.age = int.tryParse(ageController.text) ?? 0;
      widget.userData.state = _selectedState!;
      widget.userData.updateData();
    });

    await prefs.setString('numberOfDependents', numberOfDependentsController.text);
    await prefs.setString('age', ageController.text);
    await prefs.setString('state', _selectedState!);
  }

  @override
  void dispose() {
    numberOfDependentsController.removeListener(_saveData);
    ageController.removeListener(_saveData);
    numberOfDependentsController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filling Status')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  value: widget.userData.fillingStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      widget.userData.fillingStatus = newValue ?? 'Single';
                      widget.userData.updateData();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              "Filing Status: ${widget.userData.fillingStatus}")),
                    );
                  },
                  items: <String>[
                    'Single',
                    'Married, filling jointly',
                    'Married, filling separately',
                    'Head of Household'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                _buildStateSelectionField(),
                _buildAdditionalQuestions(),
              ],
            )),
      ),
    );
  }

  Widget _buildAdditionalQuestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: numberOfDependentsController,
          decoration: const InputDecoration(
            labelText: 'Number of Dependents',
            hintText: 'Enter the number of dependents',
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the number of dependents';
            }
            return null;
          },
        ),
        TextFormField(
          controller: ageController,
          decoration: const InputDecoration(
            labelText: 'What is your age',
            hintText: 'Enter your age',
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your age';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildStateSelectionField() {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return _usStates.where((String state) {
          return state.toLowerCase().startsWith(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selectedState) {
        setState(() {
          _selectedState = selectedState;
          widget.userData.state = selectedState;
          widget.userData.updateData();
          _saveData();
        });
      },
      fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          decoration: const InputDecoration(
            labelText: 'State',
            hintText: 'Enter your state',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your state';
            }
            return null;
          },
        );
      },
    );
  }
}