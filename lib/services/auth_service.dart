import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/screens/dashboard.dart';
import 'package:healthcare/screens/login_page.dart';
import 'package:http/http.dart' as http;

class AuthService{
  getCurrentUserPhoneNumber() async {
    FirebaseUser currentUser;
    currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser.phoneNumber;
  }
  //Handling Auth
  handleAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData)
        {
          return DashboardPage(documentSnapshot: snapshot,);
        }
        else{
          return LoginPage();
        }
      },
    );
  }
  signOut(){
    FirebaseAuth.instance.signOut();
  }
  signIn(AuthCredential authCredential){
    FirebaseAuth.instance.signInWithCredential(authCredential);
  }
  signInWithOTP(smsCode, verId){
    AuthCredential authCredential = PhoneAuthProvider.getCredential(verificationId: verId, smsCode: smsCode);
    signIn(authCredential);
  }
}