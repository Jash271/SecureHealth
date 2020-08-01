import 'package:flutter/material.dart';
import 'package:healthcare/screens/dashboard.dart';
import 'package:healthcare/services/db_connections.dart';

void main() {
  runApp(MyApp());
  //checkConnection();
}
checkConnection ()async{
  DBConnections connect = DBConnections();
  //await connect.verifyUser('8850356911');
  await connect.verifyUser('9082974316');
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HealthCare app',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home: AuthService().handleAuth(),
    home: DashboardPage(),
    );
  }
}