import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare/screens/account_screeen.dart';
import 'package:healthcare/screens/qr_page.dart';
import 'package:healthcare/screens/home_screen.dart';

class DashboardPage extends StatefulWidget {
  final AsyncSnapshot documentSnapshot;
  DashboardPage({this.documentSnapshot});
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  void onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  bool isLoggedIn;
  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetOptions = [
      HomeScreen(),
      QRPage(snapshot: widget.documentSnapshot,),
      AccountScreen()
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HeathCare App',
          style: GoogleFonts.montserrat(
            fontSize: 30
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(

        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.launch
              ),
            title: Text('QR code')
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.account_box,
              ),
            title: Text('Account')
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: onItemTapped,

      ),
    );
  }
}
//child: RaisedButton(
//child: Text('Sign Out'),
//onPressed: (){
//AuthService().signOut();
//},
//),