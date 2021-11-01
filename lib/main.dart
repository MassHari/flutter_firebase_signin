import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_signin/screens/signin_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

   MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization=Firebase.initializeApp();

  //This widget is root of your application
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapShot){
          if(snapShot.hasError){
            print('something went wrong');
          }
          else if(snapShot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Email & Password ',
            theme: ThemeData(
              primarySwatch: Colors.indigo
            ),
            home: const SigninScreen(),
          );
        });
  }
}
