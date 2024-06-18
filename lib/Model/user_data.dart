// File: lib/models/user_data.dart
//UserData globalUserData = UserData();
import 'dart:math';
import 'package:flutter/material.dart';


class UserData with ChangeNotifier{
  double annualSalary;
  double monthlyRent;
  String fillingStatus;
  int age;
  int dependents;
  Function()? onDataChanged;
  double owedInTaxes;
  String state;
  double ss;
  double medicare;
  double incomeAfterTaxes;
  double totalTaxes;
  double stateIncomeTax;

  UserData(
      {this.annualSalary = 0.0,
      this.monthlyRent = 0.0,
      this.fillingStatus = 'Single',
      this.age = 0,
      this.dependents = 0,
      this.owedInTaxes = 0.0,
      this.state = 'Alaska', 
      this.ss = 0.0,
      this.medicare = 0.0,
      this.incomeAfterTaxes = 0.0,
      this.totalTaxes = 0.0,
      this.stateIncomeTax = 0.0,
      });

  void updateData() {
    if (onDataChanged != null) {
      onDataChanged!();
    }
  }

  double changeNumber(UserData userData) {
  double taxPaid = 0;
  List<double> incomeBracket = [];
  final List<double> rates = [.10, .12, .22, .24, .32, .35, .37];

  if (userData.fillingStatus == 'Single' ||
      userData.fillingStatus == 'Married, filing separately') {
    incomeBracket = [0, 11000, 47150, 100525, 191950, 243725, 609350];
  } else if (userData.fillingStatus == 'Married, filing jointly') {
    incomeBracket = [0, 23200, 94300, 201050, 383900, 487450, 731200];
  } else {
    incomeBracket = [0, 16550, 63100, 100500, 191950, 243700, 609350];
  }

  for (int i = 1; i < incomeBracket.length; i++) {
    if (userData.annualSalary > incomeBracket[i - 1]) {
      double taxableIncome =
          min(userData.annualSalary, incomeBracket[i]) - incomeBracket[i - 1];
      taxPaid += taxableIncome * rates[i - 1];
    } else {
      break;
    }
  }
  if(userData.fillingStatus == 'Married, filing separately'){
    return(123123);
  }
  //print("Total Tax Paid: $taxPaid");
    return (taxPaid);

  } //class
}


