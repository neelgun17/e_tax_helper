// File: lib/models/user_data.dart
import 'dart:math';

class UserData {
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

  UserData({
    this.annualSalary = 0.0,
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
    return taxPaid;
  }

  double socialSecurity(UserData userData){

    return 0.0;
  }

static const Map<String, dynamic> taxRates = {
    'Alabama': [
      {'limit': 500.0, 'rate': 0.02},
      {'limit': 3000.0, 'rate': 0.04},
      {'rate': 0.05} // Over $3,000
    ],
    'Alaska': null, // No state income tax
    'Arizona': [
      {'limit': 26500.0, 'rate': 0.0259},
      {'limit': 53000.0, 'rate': 0.0334},
      {'limit': 159000.0, 'rate': 0.0417},
      {'rate': 0.045} // Over $159,000
    ],
    'Arkansas': [
      {'limit': 4299.0, 'rate': 0.02},
      {'limit': 8500.0, 'rate': 0.04},
      {'rate': 0.059} // Over $8,500
    ],
    'California': [
      {'limit': 8932.0, 'rate': 0.01},
      {'limit': 21175.0, 'rate': 0.02},
      {'limit': 33421.0, 'rate': 0.04},
      {'limit': 46394.0, 'rate': 0.06},
      {'limit': 58634.0, 'rate': 0.08},
      {'limit': 299508.0, 'rate': 0.093},
      {'limit': 359407.0, 'rate': 0.103},
      {'limit': 599012.0, 'rate': 0.113},
      {'limit': 1000000.0, 'rate': 0.123},
      {'rate': 0.133} // Over $1,000,000
    ],
    'Colorado': {'flat': 0.044}, // Flat rate
    'Connecticut': [
      {'limit': 10000.0, 'rate': 0.03},
      {'limit': 50000.0, 'rate': 0.05},
      {'limit': 100000.0, 'rate': 0.055},
      {'limit': 200000.0, 'rate': 0.06},
      {'limit': 250000.0, 'rate': 0.065},
      {'limit': 500000.0, 'rate': 0.069},
      {'rate': 0.0699} // Over $500,000
    ],
    'Delaware': [
      {'limit': 2000.0, 'rate': 0.022},
      {'limit': 5000.0, 'rate': 0.039},
      {'limit': 10000.0, 'rate': 0.048},
      {'limit': 20000.0, 'rate': 0.052},
      {'limit': 25000.0, 'rate': 0.0555},
      {'rate': 0.066} // Over $25,000
    ],
    'Florida': null, // No state income tax
    'Georgia': [
      {'limit': 750.0, 'rate': 0.01},
      {'limit': 2250.0, 'rate': 0.02},
      {'limit': 3750.0, 'rate': 0.03},
      {'limit': 5250.0, 'rate': 0.04},
      {'limit': 7000.0, 'rate': 0.05},
      {'rate': 0.0575} // Over $7,000
    ],
    'Hawaii': [
      {'limit': 2400.0, 'rate': 0.014},
      {'limit': 4800.0, 'rate': 0.032},
      {'limit': 9600.0, 'rate': 0.055},
      {'limit': 14400.0, 'rate': 0.064},
      {'limit': 19200.0, 'rate': 0.068},
      {'limit': 24000.0, 'rate': 0.072},
      {'limit': 36000.0, 'rate': 0.076},
      {'limit': 48000.0, 'rate': 0.079},
      {'limit': 150000.0, 'rate': 0.0825},
      {'limit': 175000.0, 'rate': 0.09},
      {'limit': 200000.0, 'rate': 0.1},
      {'rate': 0.11} // Over $200,000
    ],
    'Idaho': [
      {'limit': 1547.0, 'rate': 0.01},
      {'limit': 3095.0, 'rate': 0.03},
      {'limit': 4643.0, 'rate': 0.045},
      {'limit': 6188.0, 'rate': 0.055},
      {'limit': 7735.0, 'rate': 0.065},
      {'limit': 11512.0, 'rate': 0.075},
      {'rate': 0.0695} // Over $11,512
    ],
    'Illinois': {'flat': 0.0495}, // Flat rate
    'Indiana': {'flat': 0.0323}, // Flat rate
    'Iowa': [
      {'limit': 1638.0, 'rate': 0.0033},
      {'limit': 3276.0, 'rate': 0.0067},
      {'limit': 6552.0, 'rate': 0.0225},
      {'limit': 14742.0, 'rate': 0.0414},
      {'limit': 24570.0, 'rate': 0.0563},
      {'limit': 32760.0, 'rate': 0.0596},
      {'limit': 49140.0, 'rate': 0.0792},
      {'rate': 0.0898} // Over $49,140
    ],
    'Kansas': [
      {'limit': 15000.0, 'rate': 0.031},
      {'limit': 30000.0, 'rate': 0.0525},
      {'rate': 0.057} // Over $30,000
    ],
    'Kentucky': {'flat': 0.05}, // Flat rate
    'Louisiana': [
      {'limit': 12500.0, 'rate': 0.02},
      {'limit': 50000.0, 'rate': 0.04},
      {'rate': 0.06} // Over $50,000
    ],
    'Maine': [
      {'limit': 23000.0, 'rate': 0.058},
      {'limit': 54450.0, 'rate': 0.0675},
      {'rate': 0.0715} // Over $54,450
    ],
    'Maryland': [
      {'limit': 1000.0, 'rate': 0.02},
      {'limit': 2000.0, 'rate': 0.03},
      {'limit': 3000.0, 'rate': 0.04},
      {'limit': 100000.0, 'rate': 0.0475},
      {'limit': 125000.0, 'rate': 0.05},
      {'limit': 150000.0, 'rate': 0.0525},
      {'limit': 250000.0, 'rate': 0.055},
      {'rate': 0.0575} // Over $250,000
    ],
    'Massachusetts': {'flat': 0.05}, // Flat rate
    'Michigan': {'flat': 0.0425}, // Flat rate
    'Minnesota': [
      {'limit': 28080.0, 'rate': 0.0535},
      {'limit': 92430.0, 'rate': 0.068},
      {'limit': 171220.0, 'rate': 0.0785},
      {'rate': 0.0985} // Over $171,220
    ],
    'Mississippi': [
      {'limit': 3000.0, 'rate': 0.03},
      {'limit': 5000.0, 'rate': 0.04},
      {'rate': 0.05} // Over $5,000
    ],
    'Missouri': [
      {'limit': 1000.0, 'rate': 0.015},
      {'limit': 2000.0, 'rate': 0.02},
      {'limit': 3000.0, 'rate': 0.025},
      {'limit': 4000.0, 'rate': 0.03},
      {'limit': 5000.0, 'rate': 0.035},
      {'limit': 6000.0, 'rate': 0.04},
      {'limit': 7000.0, 'rate': 0.045},
      {'limit': 8000.0, 'rate': 0.05},
      {'limit': 9000.0, 'rate': 0.055},
      {'rate': 0.059} // Over $9,000
    ],
    'Montana': [
      {'limit': 3100.0, 'rate': 0.01},
      {'limit': 5500.0, 'rate': 0.02},
      {'limit': 8400.0, 'rate': 0.03},
      {'limit': 11400.0, 'rate': 0.04},
      {'limit': 14600.0, 'rate': 0.05},
      {'limit': 18900.0, 'rate': 0.06},
      {'rate': 0.0675} // Over $18,900
      ],
      'Nebraska': [
      {'limit': 3380.0, 'rate': 0.0246},
      {'limit': 20200.0, 'rate': 0.0351},
      {'limit': 32210.0, 'rate': 0.0501},
      {'rate': 0.0684} // Over $32,210
      ],
      'Nevada': null, // No state income tax
      'New Hampshire': {'flat': 0.05}, // Flat rate on dividends and interest income only
      'New Jersey': [
      {'limit': 20000.0, 'rate': 0.014},
      {'limit': 35000.0, 'rate': 0.0175},
      {'limit': 40000.0, 'rate': 0.035},
      {'limit': 75000.0, 'rate': 0.05525},
      {'limit': 500000.0, 'rate': 0.0637},
      {'limit': 5000000.0, 'rate': 0.0897},
      {'rate': 0.1075} // Over $5,000,000
      ],
      'New Mexico': [
      {'limit': 5500.0, 'rate': 0.017},
      {'limit': 11000.0, 'rate': 0.032},
      {'limit': 16000.0, 'rate': 0.047},
      {'limit': 21000.0, 'rate': 0.049},
      {'rate': 0.059} // Over $21,000
      ],
      'New York': [
      {'limit': 8500.0, 'rate': 0.04},
      {'limit': 11700.0, 'rate': 0.045},
      {'limit': 13900.0, 'rate': 0.0525},
      {'limit': 21400.0, 'rate': 0.059},
      {'limit': 80650.0, 'rate': 0.0621},
      {'limit': 215400.0, 'rate': 0.0649},
      {'limit': 1077550.0, 'rate': 0.0685},
      {'rate': 0.0882} // Over $1,077,550
      ],
      'North Carolina': {'flat': 0.0475}, // Flat rate
      'North Dakota': [
      {'limit': 40525.0, 'rate': 0.011},
      {'limit': 98000.0, 'rate': 0.02},
      {'limit': 204675.0, 'rate': 0.022},
      {'limit': 445000.0, 'rate': 0.024},
      {'rate': 0.026} // Over $445,000
      ],
      'Ohio': [
      {'limit': 21750.0, 'rate': 0.00}, // No tax under $21,750
      {'limit': 43500.0, 'rate': 0.0285},
      {'limit': 87000.0, 'rate': 0.03326},
      {'rate': 0.03802} // Over $87,000
      ],
      'Oklahoma': [
      {'limit': 1000.0, 'rate': 0.005},
      {'limit': 2500.0, 'rate': 0.01},
      {'limit': 3750.0, 'rate': 0.02},
      {'limit': 4900.0, 'rate': 0.03},
      {'limit': 7200.0, 'rate': 0.04},
      {'rate': 0.05} // Over $7,200
      ],
      'Oregon': [
      {'limit': 3650.0, 'rate': 0.0475},
      {'limit': 9200.0, 'rate': 0.0675},
      {'limit': 125000.0, 'rate': 0.0875},
      {'rate': 0.099} // Over $125,000
      ],
      'Pennsylvania': {'flat': 0.0307}, // Flat rate
      'Rhode Island': [
      {'limit': 68200.0, 'rate': 0.0375},
      {'limit': 155050.0, 'rate': 0.0475},
      {'rate': 0.0599} // Over $155,050
      ],
      'South Carolina': [
      {'limit': 3070.0, 'rate': 0.0}, // No tax under $3,070
      {'limit': 6150.0, 'rate': 0.03},
      {'limit': 9240.0, 'rate': 0.04},
      {'limit': 12320.0, 'rate': 0.05},
      {'limit': 15400.0, 'rate': 0.06},
      {'rate': 0.07} // Over $15,400
      ],
      'South Dakota': null, // No state income tax
      'Tennessee': null, // No state income tax (used to tax interest and dividends only)
      'Texas': null, // No state income tax
      'Utah': {'flat': 0.0485}, // Flat rate
      'Vermont': [
      {'limit': 41500.0, 'rate': 0.0335},
      {'limit': 99200.0, 'rate': 0.066},
      {'limit': 206950.0, 'rate': 0.076},
      {'rate': 0.0875} // Over $206,950
      ],
      'Virginia': [
      {'limit': 3000.0, 'rate': 0.02},
      {'limit': 5000.0, 'rate': 0.03},
      {'limit': 17000.0, 'rate': 0.05},
      {'rate': 0.0575} // Over $17,000
      ],
      'Washington': null, // No state income tax
      'West Virginia': [
      {'limit': 10000.0, 'rate': 0.03},
      {'limit': 25000.0, 'rate': 0.04},
      {'limit': 40000.0, 'rate': 0.045},
      {'limit': 60000.0, 'rate': 0.06},
      {'rate': 0.065} // Over $60,000
      ],
      'Wisconsin': [
      {'limit': 12860.0, 'rate': 0.0354},
      {'limit': 25830.0, 'rate': 0.0465},
      {'limit': 28420.0, 'rate': 0.0627},
      {'rate': 0.0765} // Over $284,20
      ],
      'Wyoming': null, // No state income tax
      'District of Columbia': [
      {'limit': 10000.0, 'rate': 0.04},
      {'limit': 40000.0, 'rate': 0.06},
      {'limit': 60000.0, 'rate': 0.065},
      {'limit': 350000.0, 'rate': 0.085},
      {'limit': 1000000.0, 'rate': 0.0875},
      {'rate': 0.0975} // Over $1,000,000
      ],
    // Add more states here
  };

double calculateStateTax(UserData userData) {
    var stateTax = taxRates[userData.state];
    double income = userData.annualSalary;
    
    if (stateTax == null) {
      return 0.0; // No state income tax
    } else if (stateTax is Map<String, dynamic> && stateTax.containsKey('flat')) {
      return income * stateTax['flat'];
    } else if (stateTax is List) {
      double tax = 0.0;
      double remainingIncome = income;

      for (var bracket in stateTax) {
        if (bracket.containsKey('limit')) {
          double limit = bracket['limit'] as double;
          double taxableIncome = remainingIncome > limit ? limit : remainingIncome;
          tax += taxableIncome * bracket['rate'];
          remainingIncome -= taxableIncome;
        } else {
          tax += remainingIncome * bracket['rate'];
          break;
        }
      }
      print(tax);
      return tax;
    } else {
      throw Exception('Invalid state tax data');
    }
  }
  
  double netIncome(UserData userData){
    return userData.annualSalary - userData.totalTaxes;
  }
}