import 'package:flutter/material.dart';
import 'Screen/Home/home.dart';
import 'Screen/Income/income.dart';
import 'Screen/PersonalInfo/personal.dart';
import 'Model/user_data.dart';
import 'Model/test.dart';
void main() {
  // ignore: prefer_const_constructors
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  List<Widget> screens = [
    HomePage(
      userData: globalUserData,
    ),
    IncomeInformationPage(
      userData: globalUserData,
    ),
    PersonalPage(
      userData: globalUserData,
    ),
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  void onClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('eTax Helper'),
          backgroundColor: Colors.green,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 125,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Text(
                    'eTaxHelper',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => onItemTapped(0),
              ),
              ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text('Income'),
                onTap: () => onItemTapped(1),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Information'),
                onTap: () => onItemTapped(2),
              ),
            ],
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: screens,
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Income',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Personal Info',
            ),
          ],
        ),
      ),
    );
  }
}
